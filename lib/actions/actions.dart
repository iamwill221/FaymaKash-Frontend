import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

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
      context.pushNamed(HomeWidget.routeName);

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
            content: Text(getJsonField(
              (depositResult?.jsonBody ?? ''),
              r'''$.detail''',
            ).toString().toString()),
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
      context.pushNamed(HomeWidget.routeName);

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
            content: Text(
                'La carte n\'est probablement pas valide. Veuillez réessayer plus tard.'),
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
      context.pushNamed(HomeWidget.routeName);

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
            content: Text(
                'La carte n\'est probablement pas valide. Veuillez réessayer plus tard.'),
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
