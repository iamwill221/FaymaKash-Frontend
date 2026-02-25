import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/nfc_reader_popup/nfc_reader_popup_widget.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'transaction_init_page_model.dart';
export 'transaction_init_page_model.dart';

class TransactionInitPageWidget extends StatefulWidget {
  const TransactionInitPageWidget({
    super.key,
    required this.transactionType,
    this.operatorCode,
  });

  final TransactionType? transactionType;
  final OperatorCode? operatorCode;

  static String routeName = 'TransactionInitPage';
  static String routePath = 'transactionInitPage';

  @override
  State<TransactionInitPageWidget> createState() =>
      _TransactionInitPageWidgetState();
}

class _TransactionInitPageWidgetState extends State<TransactionInitPageWidget> {
  late TransactionInitPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionInitPageModel());

    _model.phonenumberTextFieldTextController ??= TextEditingController();
    _model.phonenumberTextFieldFocusNode ??= FocusNode();

    _model.amountTextFieldTextController ??= TextEditingController();
    _model.amountTextFieldFocusNode ??= FocusNode();

    // Add listener to validate amount
    _model.amountTextFieldTextController?.addListener(() {
      final text = _model.amountTextFieldTextController?.text ?? '';
      final amount = int.tryParse(text) ?? 0;
      final newIsValid = amount >= 100;
      final hasTyped = text.isNotEmpty;
      
      if (_model.isAmountValid != newIsValid || _model.hasStartedTyping != hasTyped) {
        safeSetState(() {
          _model.isAmountValid = newIsValid;
          _model.hasStartedTyping = hasTyped;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {
          _model.phonenumberTextFieldTextController?.text = '+221';
        }));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
            child: Text(
              () {
                if (widget.transactionType == TransactionType.deposit) {
                  return 'Dépôt';
                } else if (widget.transactionType ==
                    TransactionType.withdraw) {
                  return 'Retrait';
                } else if (widget.transactionType == TransactionType.payment) {
                  return 'Paiement';
                } else if (widget.transactionType ==
                    TransactionType.transfer) {
                  return 'Transfert';
                } else if (widget.transactionType ==
                    TransactionType.deposit_momo) {
                  return 'Dépôt depuis opérateur';
                } else {
                  return 'Retrait vers opérateur';
                }
              }(),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 24.0, 24.0, 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Informations de la transaction',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              if ((widget.transactionType !=
                                      TransactionType.deposit) &&
                                  (widget.transactionType !=
                                      TransactionType.withdraw) &&
                                  (widget.transactionType !=
                                      TransactionType.payment))
                                TextFormField(
                                  controller:
                                      _model.phonenumberTextFieldTextController,
                                  focusNode:
                                      _model.phonenumberTextFieldFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Numéro de téléphone du client',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: '+221',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    suffixIcon: Icon(
                                      Icons.phone,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  minLines: 1,
                                  keyboardType: TextInputType.phone,
                                  validator: _model
                                      .phonenumberTextFieldTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    _model.phonenumberTextFieldMask
                                  ],
                                ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller:
                                        _model.amountTextFieldTextController,
                                    focusNode: _model.amountTextFieldFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Montant',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      suffixIcon: Icon(
                                        Icons.payments,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                    minLines: 1,
                                    keyboardType: TextInputType.number,
                                    validator: _model
                                        .amountTextFieldTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  if (_model.hasStartedTyping && !_model.isAmountValid)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 8.0, 0.0, 0.0),
                                      child: Text(
                                        'Le montant doit être au moins 100 FCFA',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme.of(context).error,
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: !_model.isAmountValid ? null : () async {
                        if (widget.transactionType ==
                                TransactionType.deposit ||
                            widget.transactionType ==
                                TransactionType.withdraw ||
                            widget.transactionType ==
                                TransactionType.payment) {
                          final isNfcReady = await actions.checkNfc();
                          if (!isNfcReady) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Erreur !'),
                                  content: Text(
                                      'Activez le module NFC ! Votre téléphone n\'est peut-être pas compatible.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: NfcReaderPopupWidget(
                                    nfcState: NFCState.Read,
                                    amount: int.tryParse(_model
                                        .amountTextFieldTextController.text),
                                    transactionType: widget.transactionType,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (widget.transactionType ==
                            TransactionType.transfer) {
                          _model.transferResult =
                              await TransactionsGroup.transferMoneyCall.call(
                            authToken: currentAuthenticationToken,
                            phoneNumber:
                                _model.phonenumberTextFieldTextController.text,
                            amount: int.tryParse(
                                _model.amountTextFieldTextController.text),
                          );

                          if ((_model.transferResult?.succeeded ?? true)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Transaction effectuée !',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Erreur'),
                                  content: Text(
                                      'Ce numéro de téléphone n\'existe pas !'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else if (widget.transactionType ==
                            TransactionType.deposit_momo) {
                          _model.depositMomoResult = await TransactionsGroup
                              .depositByMobileMoneyCall
                              .call(
                            authToken: currentAuthenticationToken,
                            phoneNumber:
                                _model.phonenumberTextFieldTextController.text,
                            amount: int.tryParse(
                                _model.amountTextFieldTextController.text),
                            operatorCode: widget.operatorCode?.name,
                          );

                          if ((_model.depositMomoResult?.succeeded ?? true)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Transaction initiée...',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            await launchURL(
                                DexchangeResponseStruct.maybeFromMap(
                                        (_model.depositMomoResult?.jsonBody ??
                                            ''))!
                                    .deepLink);

                            context.pushNamed(HomeWidget.routeName);
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Erreur'),
                                  content: Text(
                                      'La transation ne peut pas être effectuée maintenant! Réessayez plus tard!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          _model.withdrawMomoResult = await TransactionsGroup
                              .withdrawByMobileMoneyCall
                              .call(
                            authToken: currentAuthenticationToken,
                            phoneNumber:
                                _model.phonenumberTextFieldTextController.text,
                            amount: int.tryParse(
                                _model.amountTextFieldTextController.text),
                            operatorCode: widget.operatorCode?.name,
                          );

                          if ((_model.withdrawMomoResult?.succeeded ?? true)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Transaction effectuée!',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );

                            context.pushNamed(HomeWidget.routeName);
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Erreur'),
                                  content: Text(
                                      'La transation ne peut pas être effectuée maintenant! Réessayez plus tard!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }

                        safeSetState(() {});
                      },
                      text: 'Valider',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 56.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: _model.isAmountValid
                            ? FlutterFlowTheme.of(context).primary
                            : Colors.grey,
                        textStyle:
                            FlutterFlowTheme.of(context).titleLarge.override(
                                  fontFamily: 'Inter Tight',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
