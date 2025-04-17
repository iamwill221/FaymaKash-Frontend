import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/n_f_c_card/n_f_c_card_widget.dart';
import '/pages/components/transaction_item/transaction_item_widget.dart';
import '/pages/components/transaction_type_button/transaction_type_button_widget.dart';
import '/index.dart';
import 'dart:async';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Change NFC Card State)] action in UnLockCard_IconButton widget.
  ApiCallResponse? changeNfcCardState;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // Stores action output result for [Backend Call - API (Change NFC Card State)] action in LockCard_IconButton widget.
  ApiCallResponse? changeNfcCardStatee;
  // Model for NFC_Card component.
  late NFCCardModel nFCCardModel;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel1;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel2;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel3;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel4;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel5;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel6;
  // Model for TransactionTypeButton component.
  late TransactionTypeButtonModel transactionTypeButtonModel7;
  Completer<ApiCallResponse>? apiRequestCompleter2;
  // Models for TransactionItem dynamic component.
  late FlutterFlowDynamicModels<TransactionItemModel> transactionItemModels;

  @override
  void initState(BuildContext context) {
    nFCCardModel = createModel(context, () => NFCCardModel());
    transactionTypeButtonModel1 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel2 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel3 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel4 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel5 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel6 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionTypeButtonModel7 =
        createModel(context, () => TransactionTypeButtonModel());
    transactionItemModels =
        FlutterFlowDynamicModels(() => TransactionItemModel());
  }

  @override
  void dispose() {
    nFCCardModel.dispose();
    transactionTypeButtonModel1.dispose();
    transactionTypeButtonModel2.dispose();
    transactionTypeButtonModel3.dispose();
    transactionTypeButtonModel4.dispose();
    transactionTypeButtonModel5.dispose();
    transactionTypeButtonModel6.dispose();
    transactionTypeButtonModel7.dispose();
    transactionItemModels.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
