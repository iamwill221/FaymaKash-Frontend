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

Future stopNfcEmulation() async {
  final _flutterNfcHcePlugin = FlutterNfcHce();
  await _flutterNfcHcePlugin.stopNfcHce();
}
