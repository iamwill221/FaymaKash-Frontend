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
import 'package:nfc_manager/nfc_manager.dart';

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

Future<String> readNfc(BuildContext context) async {
  final completer = Completer<String>();

  await NfcManager.instance.startSession(
    onDiscovered: (NfcTag tag) async {
      String content = '';

      // Read NDEF message content
      if (tag.data['ndef'] != null) {
        final ndefData = tag.data['ndef'] as Map;
        if (ndefData['cachedMessage'] != null &&
            ndefData['cachedMessage']['records'] != null) {
          final records =
              (ndefData['cachedMessage']['records'] as List).cast<Map>();

          // Concatenate content from all records
          for (final record in records) {
            if (record['payload'] != null) {
              // Handle Text records
              if (record['type'] == 'T' ||
                  (record['type'] is List &&
                      String.fromCharCodes(record['type']).toUpperCase() ==
                          'T')) {
                content += parseNdefTextRecord(record);
              }
              // Handle URI records
              else if (record['type'] == 'U' ||
                  (record['type'] is List &&
                      String.fromCharCodes(record['type']).toUpperCase() ==
                          'U')) {
                final payload = record['payload'] as List<dynamic>;
                if (payload.isNotEmpty) {
                  // Skip the URI identifier code
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
              content += '\n'; // Add separator between records
            }
          }
        }
      }

      if (content.isEmpty) {
        completer.completeError('No NDEF content found');
        await NfcManager.instance.stopSession();
        return;
      }

      // Show dialog with the read content
      /* await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("NFC Tag Content"),
          content: Text("Content: $content"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            )
          ],
        ),
      );*/

      completer.complete(content.trim()); // Remove trailing newline
      await NfcManager.instance.stopSession();
    },
    onError: (error) async {
      await NfcManager.instance.stopSession();
      completer.completeError(error);
    },
  );

  return completer.future;
}
