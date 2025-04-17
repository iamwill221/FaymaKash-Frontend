import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'register_widget.dart' show RegisterWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterModel extends FlutterFlowModel<RegisterWidget> {
  ///  Local state fields for this page.

  String? phoneNumber;

  int currentPageViewIndex = 0;

  String? firstName;

  String? lastName;

  String userType = 'client';

  ///  State fields for stateful widgets in this page.

  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
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

  // State field(s) for prenom widget.
  FocusNode? prenomFocusNode;
  TextEditingController? prenomTextController;
  String? Function(BuildContext, String?)? prenomTextControllerValidator;
  String? _prenomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Veuillez entrer votre prénom pour continuer';
    }

    if (val.length < 2) {
      return 'Le prénom dot être supérieur à 2 caractères';
    }

    return null;
  }

  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomTextController;
  String? Function(BuildContext, String?)? nomTextControllerValidator;
  String? _nomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Veuillez entrer votre nom pour continuer';
    }

    if (val.length < 2) {
      return 'Le prénom dot être supérieur à 2 caractères';
    }

    return null;
  }

  // State field(s) for userTypeDropDown widget.
  String? userTypeDropDownValue;
  FormFieldController<String>? userTypeDropDownValueController;
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'PIN code is required';
    }
    if (val.length < 4) {
      return 'Requires 4 characters.';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? ff;
  // Stores action output result for [Backend Call - API (Send OTP)] action in Button widget.
  ApiCallResponse? otpSent;
  // Stores action output result for [Backend Call - API (Verify OTP)] action in Button widget.
  ApiCallResponse? otpVerificationResult;
  // Stores action output result for [Backend Call - API (Register)] action in Button widget.
  ApiCallResponse? registrationResult;

  @override
  void initState(BuildContext context) {
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    oTPCode = TextEditingController();
    oTPCodeValidator = _oTPCodeValidator;
    prenomTextControllerValidator = _prenomTextControllerValidator;
    nomTextControllerValidator = _nomTextControllerValidator;
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
  }

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    oTPCodeFocusNode?.dispose();
    oTPCode?.dispose();

    prenomFocusNode?.dispose();
    prenomTextController?.dispose();

    nomFocusNode?.dispose();
    nomTextController?.dispose();

    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }

  /// Action blocks.
  Future validateOTP(BuildContext context) async {}
}
