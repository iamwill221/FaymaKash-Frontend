import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'nfc_reader_popup_widget.dart' show NfcReaderPopupWidget;
import 'package:flutter/material.dart';

class NfcReaderPopupModel extends FlutterFlowModel<NfcReaderPopupWidget> {
  ///  Local state fields for this component.

  int timer = 10;

  bool isProcessing = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - checkNfc] action in NfcReaderPopup widget.
  bool? nfcCheckResult;
  // Stores action output result for [Custom Action - readNfc] action in NfcReaderPopup widget.
  String? readNfcResult;
  // Stores action output result for [Backend Call - API (Update virtual card identifier)] action in NfcReaderPopup widget.
  ApiCallResponse? updateVirtualCardResult;
  InstantTimer? instantTimer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
