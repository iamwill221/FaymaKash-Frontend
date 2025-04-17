import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

class MobileMoneyChoiceModel extends FlutterFlowModel<MobileMoneyChoiceWidget> {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future chooseOperator(
    BuildContext context, {
    OperatorCode? operatorCode,
  }) async {
    if (widget!.transactionType == TransactionType.deposit_momo) {
      context.pushNamed(
        TransactionInitPageWidget.routeName,
        queryParameters: {
          'operatorCode': serializeParam(
            OperatorCode.WAVE_SN_CASHOUT,
            ParamType.Enum,
          ),
          'transactionType': serializeParam(
            TransactionType.deposit_momo,
            ParamType.Enum,
          ),
        }.withoutNulls,
      );
    } else {
      context.pushNamed(
        TransactionInitPageWidget.routeName,
        queryParameters: {
          'operatorCode': serializeParam(
            OperatorCode.WAVE_SN_CASHIN,
            ParamType.Enum,
          ),
          'transactionType': serializeParam(
            TransactionType.withdraw,
            ParamType.Enum,
          ),
        }.withoutNulls,
      );
    }
  }
}
