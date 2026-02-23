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

import 'package:flutter_nfc_hce/flutter_nfc_hce.dart';

Future<bool> checkNfcHceSupported() async {
  try {
    final plugin = FlutterNfcHce();
    final isSupported = await plugin.isNfcHceSupported();
    if (isSupported != true) return false;
    final isEnabled = await plugin.isNfcEnabled();
    return isEnabled == true;
  } catch (e) {
    return false;
  }
}

Future startNfcEmulation(BuildContext context, String virtualCardToken) async {
  final plugin = FlutterNfcHce();
  var result = await plugin.startNfcHce(virtualCardToken);
  print('NFC HCE Result: $result');
}
