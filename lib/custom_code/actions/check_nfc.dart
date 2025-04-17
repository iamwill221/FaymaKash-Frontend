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

import 'package:nfc_manager/nfc_manager.dart';

Future<bool> checkNfc() async {
  // check if the device supports NFC and returns a boolean

  bool isNfcSupported = false;

  try {
    isNfcSupported = await NfcManager.instance.isAvailable();
  } catch (e) {
    print("Error checking NFC support: $e");
  }

  return isNfcSupported;
}
