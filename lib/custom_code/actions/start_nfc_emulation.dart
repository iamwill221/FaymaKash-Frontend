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

Future startNfcEmulation(BuildContext context, String virtualCardToken) async {
  // Plugin instance
  final _flutterNfcHcePlugin = FlutterNfcHce();

  // Get platform version
  var platformVersion = await _flutterNfcHcePlugin.getPlatformVersion();
  print('Platform Version: $platformVersion');

  // Check if NFC HCE is supported
  bool? isNfcHceSupported = await _flutterNfcHcePlugin.isNfcHceSupported();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('NFC HCE Support'),
        content: Text(isNfcHceSupported == true
            ? 'NFC HCE is supported.'
            : 'NFC HCE is not supported.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  // Check if secure NFC is enabled
  bool? isSecureNfcEnabled = await _flutterNfcHcePlugin.isSecureNfcEnabled();

  // Check if NFC is enabled
  bool? isNfcEnabled = await _flutterNfcHcePlugin.isNfcEnabled();

  // NFC content
  var content = virtualCardToken;

  // Start NFC HCE
  var result = await _flutterNfcHcePlugin.startNfcHce(content);
  print('NFC HCE Result: $result');
}
