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
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart';

Future<bool> checkNfcHceSupported() async {
  try {
    final nfcState = await NfcHce.checkDeviceNfcState();
    return nfcState == NfcState.enabled;
  } catch (e) {
    return false;
  }
}

Future startNfcEmulation(BuildContext context, String virtualCardToken) async {
  if (kDebugMode) {
    print('NFC HCE: Starting emulation with token length: ${virtualCardToken.length}');
    print('NFC HCE: Token preview: ${virtualCardToken.substring(0, virtualCardToken.length > 20 ? 20 : virtualCardToken.length)}...');
  }

  await NfcHce.init(
    aid: Uint8List.fromList([0xF0, 0x46, 0x41, 0x59, 0x4D, 0x41, 0x4B]),
    permanentApduResponses: true,
    listenOnlyConfiguredPorts: false,
  );

  // Convert token string to bytes and add as APDU response on port 0
  final tokenBytes = Uint8List.fromList(virtualCardToken.codeUnits);
  await NfcHce.addApduResponse(0, tokenBytes);

  if (kDebugMode) {
    print('NFC HCE: Emulation should now be active');
  }

  // Listen for incoming APDU command (= PDA has read the card).
  // Complete as soon as the first command arrives so the caller knows to close the popup.
  final completer = Completer<void>();
  late StreamSubscription sub;
  sub = NfcHce.stream.listen((command) {
    if (kDebugMode) {
      print('NFC HCE: APDU command received — card was read by PDA');
    }
    if (!completer.isCompleted) {
      completer.complete();
    }
    sub.cancel();
  });

  return completer.future;
}
