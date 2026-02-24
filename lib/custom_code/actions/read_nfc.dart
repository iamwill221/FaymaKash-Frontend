// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert'; // For utf8.decode
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

// Helper function to parse an NDEF text record
String parseNdefTextRecord(dynamic record) {
  if (record is Map && record.containsKey('payload')) {
    final payload = record['payload'] as List<dynamic>;
    if (payload.isNotEmpty) {
      final int status = payload[0];
      final bool isUtf16 = (status & 0x80) != 0;
      final int languageCodeLength = status & 0x3F;
      final List<int> textBytes =
          payload.sublist(1 + languageCodeLength).cast<int>();
      try {
        if (isUtf16) {
          return String.fromCharCodes(textBytes);
        } else {
          return utf8.decode(textBytes);
        }
      } catch (e) {
        print('Error decoding text record: $e');
        return '';
      }
    }
  }
  return '';
}

/// Try to parse NDEF content from raw tag.data['ndef'] cached message
String _tryParseCachedNdef(NfcTag tag) {
  String content = '';
  if (tag.data['ndef'] != null) {
    final ndefData = tag.data['ndef'] as Map;
    if (ndefData['cachedMessage'] != null &&
        ndefData['cachedMessage']['records'] != null) {
      final records =
          (ndefData['cachedMessage']['records'] as List).cast<Map>();

      for (final record in records) {
        if (record['payload'] != null) {
          // Handle Text records
          if (record['type'] == 'T' ||
              (record['type'] is List &&
                  String.fromCharCodes(record['type']).toUpperCase() == 'T')) {
            content += parseNdefTextRecord(record);
          }
          // Handle URI records
          else if (record['type'] == 'U' ||
              (record['type'] is List &&
                  String.fromCharCodes(record['type']).toUpperCase() == 'U')) {
            final payload = record['payload'] as List<dynamic>;
            if (payload.isNotEmpty) {
              final uriBytes = payload.sublist(1).cast<int>();
              content += utf8.decode(uriBytes);
            }
          }
          // Handle other record types as raw text
          else {
            try {
              final payload = record['payload'] as List<dynamic>;
              content += utf8.decode(payload.cast<int>());
            } catch (e) {
              print('Error decoding record: $e');
            }
          }
          content += '\n';
        }
      }
    }
  }
  return content.trim();
}

/// Try to read NDEF via explicit Ndef.read() call
Future<String> _tryExplicitNdefRead(NfcTag tag) async {
  try {
    final ndef = Ndef.from(tag);
    if (ndef == null) {
      print('NFC Reader: Ndef technology not available on this tag');
      return '';
    }
    print('NFC Reader: Ndef technology found, reading...');
    final message = await ndef.read();
    String content = '';
    for (final record in message.records) {
      if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown) {
        final typeStr = utf8.decode(record.type);
        if (typeStr == 'T') {
          // Text record
          final payload = record.payload;
          if (payload.isNotEmpty) {
            final int status = payload[0];
            final int langLen = status & 0x3F;
            final textBytes = payload.sublist(1 + langLen);
            content += utf8.decode(textBytes);
          }
        } else if (typeStr == 'U') {
          final payload = record.payload;
          if (payload.isNotEmpty) {
            content += utf8.decode(payload.sublist(1));
          }
        }
      } else {
        // Try raw decode
        try {
          content += utf8.decode(record.payload);
        } catch (e) {
          print('NFC Reader: Could not decode record payload: $e');
        }
      }
      content += '\n';
    }
    return content.trim();
  } catch (e) {
    print('NFC Reader: Explicit NDEF read failed: $e');
    return '';
  }
}

/// Try to read HCE data via IsoDep APDU commands (fallback for HCE phones)
Future<String> _tryIsoDepRead(NfcTag tag) async {
  try {
    final isoDep = IsoDep.from(tag);
    if (isoDep == null) {
      print('NFC Reader: IsoDep technology not available');
      return '';
    }
    print('NFC Reader: IsoDep found, trying APDU commands for HCE...');

    // Step 1: SELECT FaymaKash HCE Application (Custom AID: F04641594D414B = "F0FAYMAK")
    // Using proprietary AID prefix F0 to avoid conflicts with standard NDEF AID D2760000850101
    // which caused AppChooserActivity on client phones with multiple NFC apps installed.
    final selectApp = Uint8List.fromList([
      0x00, 0xA4, 0x04, 0x00, 0x07,
      0xF0, 0x46, 0x41, 0x59, 0x4D, 0x41, 0x4B, 0x00
    ]);
    final selectAppResp = await isoDep.transceive(data: selectApp);
    print('NFC Reader: SELECT App response: $selectAppResp');

    if (!_isSuccess(selectAppResp)) {
      print('NFC Reader: SELECT NDEF App failed');
      return '';
    }

    // Step 2: SELECT Capability Container (CC) file
    final selectCC = Uint8List.fromList([
      0x00, 0xA4, 0x00, 0x0C, 0x02, 0xE1, 0x03
    ]);
    final selectCCResp = await isoDep.transceive(data: selectCC);
    print('NFC Reader: SELECT CC response: $selectCCResp');

    if (_isSuccess(selectCCResp)) {
      // Step 3: READ Capability Container
      final readCC = Uint8List.fromList([
        0x00, 0xB0, 0x00, 0x00, 0x0F
      ]);
      final ccData = await isoDep.transceive(data: readCC);
      print('NFC Reader: CC data: $ccData');
    }

    // Step 4: SELECT NDEF file
    final selectNdef = Uint8List.fromList([
      0x00, 0xA4, 0x00, 0x0C, 0x02, 0xE1, 0x04
    ]);
    final selectNdefResp = await isoDep.transceive(data: selectNdef);
    print('NFC Reader: SELECT NDEF file response: $selectNdefResp');

    if (!_isSuccess(selectNdefResp)) {
      print('NFC Reader: SELECT NDEF file failed');
      return '';
    }

    // Step 5: READ NDEF file length (first 2 bytes)
    final readLen = Uint8List.fromList([
      0x00, 0xB0, 0x00, 0x00, 0x02
    ]);
    final lenData = await isoDep.transceive(data: readLen);
    print('NFC Reader: NDEF length data: $lenData');

    if (lenData.length < 4 || !_isSuccess(lenData)) {
      print('NFC Reader: Could not read NDEF length');
      return '';
    }

    final ndefLen = (lenData[0] << 8) | lenData[1];
    print('NFC Reader: NDEF message length: $ndefLen bytes');

    if (ndefLen == 0 || ndefLen > 1024) {
      print('NFC Reader: Invalid NDEF length: $ndefLen');
      return '';
    }

    // Step 6: READ NDEF data in chunks (MLe = 59 bytes max per read)
    const int chunkSize = 59;
    final allBytes = <int>[];
    int offset = 2; // Skip the 2-byte NLEN that we already read

    while (allBytes.length < ndefLen) {
      final remaining = ndefLen - allBytes.length;
      final toRead = remaining > chunkSize ? chunkSize : remaining;
      final offsetHigh = (offset >> 8) & 0xFF;
      final offsetLow = offset & 0xFF;

      final readData = Uint8List.fromList([
        0x00, 0xB0, offsetHigh, offsetLow, toRead & 0xFF
      ]);
      final chunk = await isoDep.transceive(data: readData);

      if (!_isSuccess(chunk) || chunk.length < 3) {
        print('NFC Reader: READ BINARY chunk failed at offset $offset');
        break;
      }

      // Response = data bytes + SW1 SW2
      final dataBytes = chunk.sublist(0, chunk.length - 2);
      allBytes.addAll(dataBytes);
      offset += dataBytes.length;
      print('NFC Reader: Read ${dataBytes.length} bytes at offset ${offset - dataBytes.length}, total: ${allBytes.length}/$ndefLen');
    }

    if (allBytes.isEmpty) {
      print('NFC Reader: Could not read NDEF data');
      return '';
    }

    // Parse NDEF message bytes
    final ndefBytes = Uint8List.fromList(allBytes);
    print('NFC Reader: Full NDEF data (${ndefBytes.length} bytes): $ndefBytes');
    return _parseNdefBytes(ndefBytes);
  } catch (e) {
    print('NFC Reader: IsoDep APDU error: $e');
    return '';
  }
}

/// Check if APDU response ends with SW 9000 (success)
bool _isSuccess(Uint8List response) {
  return response.length >= 2 &&
      response[response.length - 2] == 0x90 &&
      response[response.length - 1] == 0x00;
}

/// Parse raw NDEF message bytes to extract text content
String _parseNdefBytes(Uint8List bytes) {
  try {
    if (bytes.isEmpty) return '';

    // Full NDEF record parser (handles SR, IL flags correctly)
    int offset = 0;
    String content = '';

    while (offset < bytes.length) {
      if (offset >= bytes.length) break;
      final flags = bytes[offset++];
      final bool mb = (flags & 0x80) != 0; // Message Begin
      final bool me = (flags & 0x40) != 0; // Message End
      final bool sr = (flags & 0x10) != 0; // Short Record (1-byte payload length)
      final bool il = (flags & 0x08) != 0; // ID Length field present
      final int tnf = flags & 0x07;        // Type Name Format

      if (offset >= bytes.length) break;
      final typeLength = bytes[offset++];

      int payloadLength;
      if (sr) {
        if (offset >= bytes.length) break;
        payloadLength = bytes[offset++];
      } else {
        if (offset + 3 >= bytes.length) break;
        payloadLength = (bytes[offset] << 24) |
            (bytes[offset + 1] << 16) |
            (bytes[offset + 2] << 8) |
            bytes[offset + 3];
        offset += 4;
      }

      // Read ID length byte if IL flag is set (must be read before type bytes)
      int idLength = 0;
      if (il) {
        if (offset >= bytes.length) break;
        idLength = bytes[offset++];
      }

      // Read type bytes
      if (offset + typeLength > bytes.length) break;
      final typeBytes = bytes.sublist(offset, offset + typeLength);
      offset += typeLength;

      // Skip ID bytes (present when IL=1)
      if (idLength > 0) {
        if (offset + idLength > bytes.length) break;
        offset += idLength;
      }

      // Get payload
      if (offset + payloadLength > bytes.length) break;
      final payload = bytes.sublist(offset, offset + payloadLength);
      offset += payloadLength;

      // Decode based on TNF
      if (tnf == 0x01) {
        // NFC Well-Known type
        final typeStr = utf8.decode(typeBytes);
        print('NFC Reader: NDEF record type="$typeStr" tnf=$tnf il=$il idLen=$idLength payloadLen=$payloadLength');
        if (typeStr == 'T' && payload.isNotEmpty) {
          // Text record: [status byte][language bytes][text bytes]
          final status = payload[0];
          final langLen = status & 0x3F;
          final textBytes = payload.sublist(1 + langLen);
          content += utf8.decode(textBytes);
        } else if (typeStr == 'U' && payload.isNotEmpty) {
          content += utf8.decode(payload.sublist(1));
        }
      } else {
        // Try raw decode for other TNF types
        try {
          content += utf8.decode(payload);
        } catch (_) {}
      }

      if (me) break;
    }

    print('NFC Reader: Parsed NDEF content from bytes: $content');
    return content.trim();
  } catch (e) {
    // Last resort: try to decode the raw bytes as UTF-8
    try {
      final raw = utf8.decode(bytes);
      print('NFC Reader: Fallback raw decode: $raw');
      return raw.trim();
    } catch (_) {
      print('NFC Reader: Failed to parse NDEF bytes: $e');
      return '';
    }
  }
}

Future<String> readNfc(BuildContext context) async {
  final completer = Completer<String>();

  await NfcManager.instance.startSession(
    onDiscovered: (NfcTag tag) async {
      print('NFC Reader: Tag discovered!');
      print('NFC Reader: Available technologies: ${tag.data.keys.toList()}');

      // Method 1: Try cached NDEF data (works for physical NFC cards)
      String content = _tryParseCachedNdef(tag);
      if (content.isNotEmpty) {
        print('NFC Reader: Got content from cached NDEF: $content');
        completer.complete(content);
        await NfcManager.instance.stopSession();
        return;
      }

      // Method 2: Try explicit NDEF read (may work better for HCE)
      print('NFC Reader: No cached NDEF, trying explicit read...');
      content = await _tryExplicitNdefRead(tag);
      if (content.isNotEmpty) {
        print('NFC Reader: Got content from explicit NDEF read: $content');
        completer.complete(content);
        await NfcManager.instance.stopSession();
        return;
      }

      // Method 3: Try IsoDep APDU commands (fallback for HCE phones)
      print('NFC Reader: No NDEF data, trying IsoDep APDU...');
      content = await _tryIsoDepRead(tag);
      if (content.isNotEmpty) {
        print('NFC Reader: Got content from IsoDep: $content');
        completer.complete(content);
        await NfcManager.instance.stopSession();
        return;
      }

      // Nothing worked
      print('NFC Reader: All methods failed. Tag data: ${tag.data}');
      completer.completeError('No NFC content found');
      await NfcManager.instance.stopSession();
    },
    onError: (error) async {
      print('NFC Reader: Session error: $error');
      await NfcManager.instance.stopSession();
      completer.completeError(error);
    },
  );

  return completer.future;
}