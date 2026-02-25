import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'transaction_init_page_widget.dart' show TransactionInitPageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TransactionInitPageModel
    extends FlutterFlowModel<TransactionInitPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field for amount validation
  bool isAmountValid = false;
  bool hasStartedTyping = false;

  // State field(s) for phonenumberTextField widget.
  FocusNode? phonenumberTextFieldFocusNode;
  TextEditingController? phonenumberTextFieldTextController;
  final phonenumberTextFieldMask =
      MaskTextInputFormatter(mask: '+221 ## ### ## ##');
  String? Function(BuildContext, String?)?
      phonenumberTextFieldTextControllerValidator;
  // State field(s) for amountTextField widget.
  FocusNode? amountTextFieldFocusNode;
  TextEditingController? amountTextFieldTextController;
  String? Function(BuildContext, String?)?
      amountTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Transfer money)] action in Button widget.
  ApiCallResponse? transferResult;
  // Stores action output result for [Backend Call - API (Deposit by MobileMoney)] action in Button widget.
  ApiCallResponse? depositMomoResult;
  // Stores action output result for [Backend Call - API (Withdraw by MobileMoney)] action in Button widget.
  ApiCallResponse? withdrawMomoResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phonenumberTextFieldFocusNode?.dispose();
    phonenumberTextFieldTextController?.dispose();

    amountTextFieldFocusNode?.dispose();
    amountTextFieldTextController?.dispose();
  }
}
