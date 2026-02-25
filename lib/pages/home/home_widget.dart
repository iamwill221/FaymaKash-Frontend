import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/empty_list_widget/empty_list_widget_widget.dart';
import '/pages/components/n_f_c_card/n_f_c_card_widget.dart';
import '/pages/components/nfc_reader_popup/nfc_reader_popup_widget.dart';
import '/pages/components/transaction_item/transaction_item_widget.dart';
import '/pages/components/transaction_type_button/transaction_type_button_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = 'home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    animationsMap.addAll({
      'nFCCardOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 130.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.01, 1.01),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<ApiCallResponse>(
                  future: (_model.apiRequestCompleter1 ??=
                          Completer<ApiCallResponse>()
                            ..complete(AuthGroup.getCurrentUserCall.call(
                              authToken: currentAuthenticationToken,
                            )))
                      .future,
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    final headColumnGetCurrentUserResponse = snapshot.data!;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              if ((currentUserData?.userType ==
                                      UserType.client) &&
                                  !AuthGroup.getCurrentUserCall.isCardActive(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  )!)
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 47.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    showLoadingIndicator: true,
                                    onPressed: () async {
                                      _model.changeNfcCardState =
                                          await NfcCardGroup
                                              .changeNFCCardStateCall
                                              .call(
                                        cardActivationStatus: true,
                                        authToken: currentAuthenticationToken,
                                      );

                                      if ((_model
                                              .changeNfcCardState?.succeeded ??
                                          true)) {
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Erreur !'),
                                              content: Text(
                                                  'Veuillez vérifier votre connexion internet'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              if ((currentUserData?.userType ==
                                      UserType.client) &&
                                  AuthGroup.getCurrentUserCall.isCardActive(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  )!)
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 47.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    icon: Icon(
                                      Icons.lock_open,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      _model.changeNfcCardStatee =
                                          await NfcCardGroup
                                              .changeNFCCardStateCall
                                              .call(
                                        authToken: currentAuthenticationToken,
                                        cardActivationStatus: false,
                                      );

                                      if ((_model
                                              .changeNfcCardStatee?.succeeded ??
                                          true)) {
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Erreur !'),
                                              content: Text(
                                                  'Veuillez vérifier votre connecition internet'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 47.0,
                                  fillColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  icon: Icon(
                                    Icons.login_sharp,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    GoRouter.of(context).prepareAuthEvent();
                                    await authManager.signOut();
                                    GoRouter.of(context)
                                        .clearRedirectLocation();

                                    context.goNamedAuth(WelcomeWidget.routeName,
                                        context.mounted);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if ((currentUserData?.userType ==
                                        UserType.client) &&
                                    AuthGroup.getCurrentUserCall.isCardActive(
                                      headColumnGetCurrentUserResponse.jsonBody,
                                    )!) {
                                  final isHceReady =
                                      await actions.checkNfcHceSupported();
                                  if (!isHceReady) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Erreur !'),
                                          content: Text(
                                              'Activez le NFC ou votre téléphone n\'est pas compatible avec le paiement par carte virtuelle (HCE).'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  if (animationsMap[
                                          'nFCCardOnActionTriggerAnimation'] !=
                                      null) {
                                    await animationsMap[
                                            'nFCCardOnActionTriggerAnimation']!
                                        .controller
                                        .forward(from: 0.0);
                                  }
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: NfcReaderPopupWidget(
                                            nfcState: NFCState.Emulate,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  // Refresh transaction history & user data after HCE scan
                                  safeSetState(() {
                                    _model.apiRequestCompleter1 = null;
                                    _model.apiRequestCompleter2 = null;
                                  });
                                }
                              },
                              child: wrapWithModel(
                                model: _model.nFCCardModel,
                                updateCallback: () => safeSetState(() {}),
                                child: NFCCardWidget(
                                  cashAmount: AuthGroup.getCurrentUserCall.cash(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  ),
                                  fullname:
                                      '${AuthGroup.getCurrentUserCall.firstname(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  )} ${AuthGroup.getCurrentUserCall.lastname(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  )}',
                                  isActive:
                                      AuthGroup.getCurrentUserCall.isCardActive(
                                    headColumnGetCurrentUserResponse.jsonBody,
                                  )!,
                                ),
                              ),
                            ).animateOnActionTrigger(
                              animationsMap['nFCCardOnActionTriggerAnimation']!,
                            ),
                          ),
                        ),
                        if (currentUserData?.userType == UserType.client)
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: wrapWithModel(
                                        model:
                                            _model.transactionTypeButtonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: TransactionTypeButtonWidget(
                                          buttonName: 'Dépôt via\nMobile Money',
                                          icon: Icon(
                                            Icons.payments,
                                            color: Colors.white,
                                          ),
                                          actionToLaunch: () async {
                                            context.pushNamed(
                                              MobileMoneyChoiceWidget.routeName,
                                              queryParameters: {
                                                'transactionType':
                                                    serializeParam(
                                                  TransactionType.deposit_momo,
                                                  ParamType.Enum,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: wrapWithModel(
                                        model:
                                            _model.transactionTypeButtonModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: TransactionTypeButtonWidget(
                                          buttonName:
                                              'Transfert vers\ncompte FK',
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          actionToLaunch: () async {
                                            context.pushNamed(
                                              TransactionInitPageWidget
                                                  .routeName,
                                              queryParameters: {
                                                'transactionType':
                                                    serializeParam(
                                                  TransactionType.transfer,
                                                  ParamType.Enum,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: wrapWithModel(
                                          model: _model
                                              .transactionTypeButtonModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TransactionTypeButtonWidget(
                                            buttonName: 'Retrait \nvers MM',
                                            icon: Icon(
                                              Icons.network_ping,
                                              color: Colors.white,
                                            ),
                                            actionToLaunch: () async {
                                              context.pushNamed(
                                                MobileMoneyChoiceWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'transactionType':
                                                      serializeParam(
                                                    TransactionType
                                                        .withdraw_momo,
                                                    ParamType.Enum,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ].divide(SizedBox(height: 15.0)),
                    );
                  },
                ),
                if (currentUserData?.userType == UserType.manager)
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.transactionTypeButtonModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: TransactionTypeButtonWidget(
                                buttonName: 'Paiement',
                                icon: Icon(
                                  Icons.payments,
                                  color: Colors.white,
                                ),
                                actionToLaunch: () async {
                                  context.pushNamed(
                                    TransactionInitPageWidget.routeName,
                                    queryParameters: {
                                      'transactionType': serializeParam(
                                        TransactionType.payment,
                                        ParamType.Enum,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.transactionTypeButtonModel5,
                              updateCallback: () => safeSetState(() {}),
                              child: TransactionTypeButtonWidget(
                                buttonName: 'Transfert',
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                actionToLaunch: () async {
                                  context.pushNamed(
                                    TransactionInitPageWidget.routeName,
                                    queryParameters: {
                                      'transactionType': serializeParam(
                                        TransactionType.transfer,
                                        ParamType.Enum,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.transactionTypeButtonModel6,
                              updateCallback: () => safeSetState(() {}),
                              child: TransactionTypeButtonWidget(
                                buttonName: 'Dépôt client',
                                icon: Icon(
                                  Icons.transit_enterexit,
                                  color: Colors.white,
                                ),
                                actionToLaunch: () async {
                                  context.pushNamed(
                                    TransactionInitPageWidget.routeName,
                                    queryParameters: {
                                      'transactionType': serializeParam(
                                        TransactionType.deposit,
                                        ParamType.Enum,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.transactionTypeButtonModel7,
                              updateCallback: () => safeSetState(() {}),
                              child: TransactionTypeButtonWidget(
                                buttonName: 'Retrait client',
                                icon: Icon(
                                  Icons.network_ping,
                                  color: Colors.white,
                                ),
                                actionToLaunch: () async {
                                  context.pushNamed(
                                    TransactionInitPageWidget.routeName,
                                    queryParameters: {
                                      'transactionType': serializeParam(
                                        TransactionType.withdraw,
                                        ParamType.Enum,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Flexible(
                  child: FutureBuilder<ApiCallResponse>(
                    future: (_model.apiRequestCompleter2 ??=
                            Completer<ApiCallResponse>()
                              ..complete(TransactionsGroup
                                  .listAllTransactionsFromCurrentUserCall
                                  .call(
                                authToken: currentAuthenticationToken,
                              )))
                        .future,
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final historiqueListAllTransactionsFromCurrentUserResponse =
                          snapshot.data!;

                      return Container(
                        width: 500.0,
                        constraints: BoxConstraints(
                          maxWidth: 570.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFFE5E7EB),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 12.0, 12.0),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await Future.wait([
                                Future(() async {
                                  safeSetState(
                                      () => _model.apiRequestCompleter2 = null);
                                  await _model.waitForApiRequestCompleted2();
                                }),
                                Future(() async {
                                  safeSetState(
                                      () => _model.apiRequestCompleter1 = null);
                                  await _model.waitForApiRequestCompleted1();
                                }),
                              ]);
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Historique',
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF15161E),
                                                    fontSize: 22.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Text(
                                              'Transactions récentes',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Color(0xFF606A85),
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 2.0,
                                    thickness: 1.0,
                                    color: Color(0xFFE5E7EB),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final transaction =
                                          (historiqueListAllTransactionsFromCurrentUserResponse
                                                          .jsonBody
                                                          .toList()
                                                          .map<TransactionStruct?>(
                                                              TransactionStruct
                                                                  .maybeFromMap)
                                                          .toList()
                                                      as Iterable<
                                                          TransactionStruct?>)
                                                  .withoutNulls
                                                  .toList() ??
                                              [];
                                      if (transaction.isEmpty) {
                                        return EmptyListWidgetWidget();
                                      }

                                      return ListView.separated(
                                        padding: EdgeInsets.fromLTRB(
                                          0,
                                          12.0,
                                          0,
                                          12.0,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: transaction.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 1.0),
                                        itemBuilder:
                                            (context, transactionIndex) {
                                          final transactionItem =
                                              transaction[transactionIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                TransactionDetailPageWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'transaction': serializeParam(
                                                    transactionItem,
                                                    ParamType.DataStruct,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: wrapWithModel(
                                              model: _model
                                                  .transactionItemModels
                                                  .getModel(
                                                transactionIndex.toString(),
                                                transactionIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: TransactionItemWidget(
                                                key: Key(
                                                  'Keyqlu_${transactionIndex.toString()}',
                                                ),
                                                name: transactionItem
                                                    .otherUser.fullname,
                                                amount: transactionItem.amount
                                                    .toDouble(),
                                                date: transactionItem.timestamp,
                                                phoneNumber: transactionItem
                                                    .otherUser.phoneNumber,
                                                transactionType: transactionItem
                                                    .transactionType,
                                                transactionStatus:
                                                    transactionItem.status,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ].divide(SizedBox(height: 15.0)),
            ),
          ),
        ),
      ),
    );
  }
}
