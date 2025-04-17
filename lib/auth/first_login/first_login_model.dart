import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'first_login_widget.dart' show FirstLoginWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FirstLoginModel extends FlutterFlowModel<FirstLoginWidget> {
  ///  Local state fields for this page.

  int currentPageViewIndex = 0;

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '+221 ## ### ## ##');
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '+221 is required';
    }

    if (!RegExp('^\\+221\\s(?:33|70|75|76|77|78)\\s\\d{3}\\s\\d{2}\\s\\d{2}\$')
        .hasMatch(val)) {
      return 'Mauvais numéro';
    }
    return null;
  }

  // State field(s) for OTPCode widget.
  TextEditingController? oTPCode;
  FocusNode? oTPCodeFocusNode;
  String? Function(BuildContext, String?)? oTPCodeValidator;
  String? _oTPCodeValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Code OTP obligatoire !\n';
    }
    if (val.length < 6) {
      return 'Requires 6 characters.';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? ff;
  // Stores action output result for [Backend Call - API (CheckUserExistence)] action in Button widget.
  ApiCallResponse? checkUserExistenceResult;
  // Stores action output result for [Backend Call - API (Verify OTP)] action in Button widget.
  ApiCallResponse? otpVerificationResult;

  @override
  void initState(BuildContext context) {
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    oTPCode = TextEditingController();
    oTPCodeValidator = _oTPCodeValidator;
  }

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    oTPCodeFocusNode?.dispose();
    oTPCode?.dispose();
  }
}
