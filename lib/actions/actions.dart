import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

String _extractApiError(dynamic jsonBody) {
  if (jsonBody == null) return 'Une erreur est survenue. Veuillez réessayer.';
  // {"detail": "msg"} or {"detail": ["msg"]}
  final detail = getJsonField(jsonBody, r'''$.detail''');
  if (detail != null) {
    if (detail is List && detail.isNotEmpty) return detail.first.toString();
    return detail.toString();
  }
  // ["msg"] — DRF ValidationError
  if (jsonBody is List && jsonBody.isNotEmpty) return jsonBody.first.toString();
  // {"non_field_errors": ["msg"]}
  final nfe = getJsonField(jsonBody, r'''$.non_field_errors''');
  if (nfe != null) {
    if (nfe is List && nfe.isNotEmpty) return nfe.first.toString();
    return nfe.toString();
  }
  return 'Une erreur est survenue. Veuillez réessayer.';
}

Future executeManagerTransaction(
  BuildContext context, {
  required TransactionType? transactionType,
  required int? amount,
  required String? nfcCardIdentifier,
}) async {
  ApiCallResponse? depositResult;
  ApiCallResponse? withdrawResult;
  ApiCallResponse? paymentResult;

  if (transactionType == TransactionType.deposit) {
    depositResult = await TransactionsGroup.depositMoneyCall.call(
      amount: amount,
      authToken: currentAuthenticationToken,
      identifier: nfcCardIdentifier,
    );

    if ((depositResult.succeeded ?? true)) {
      Navigator.pop(context);
      context.goNamed(HomeWidget.routeName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dépôt effectué avec succès',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Erreur!'),
            content: Text(_extractApiError(depositResult?.jsonBody)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  } else if (transactionType == TransactionType.withdraw) {
    withdrawResult = await TransactionsGroup.withdrawMoneyCall.call(
      amount: amount,
      identifier: nfcCardIdentifier,
      authToken: currentAuthenticationToken,
    );

    if ((withdrawResult.succeeded ?? true)) {
      Navigator.pop(context);
      context.goNamed(HomeWidget.routeName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Retrait effectué avec succès',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Erreur!'),
            content: Text(_extractApiError(withdrawResult?.jsonBody)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  } else if (transactionType == TransactionType.payment) {
    paymentResult = await TransactionsGroup.paymentCall.call(
      amount: amount,
      identifier: nfcCardIdentifier,
      authToken: currentAuthenticationToken,
    );

    if ((paymentResult.succeeded ?? true)) {
      Navigator.pop(context);
      context.goNamed(HomeWidget.routeName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Paiement effectué avec succès',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Erreur!'),
            content: Text(_extractApiError(paymentResult?.jsonBody)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }
}
