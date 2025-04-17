import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'mobile_money_choice_model.dart';
export 'mobile_money_choice_model.dart';

/// A page with a gridview to choose between mobile money operators : wave,
/// orange money, free and wizall.
///
/// Each mobile money has a card with the logo and name of the operator
class MobileMoneyChoiceWidget extends StatefulWidget {
  const MobileMoneyChoiceWidget({
    super.key,
    required this.transactionType,
  });

  final TransactionType? transactionType;

  static String routeName = 'MobileMoneyChoice';
  static String routePath = 'mobileMoneyChoice';

  @override
  State<MobileMoneyChoiceWidget> createState() =>
      _MobileMoneyChoiceWidgetState();
}

class _MobileMoneyChoiceWidgetState extends State<MobileMoneyChoiceWidget> {
  late MobileMoneyChoiceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MobileMoneyChoiceModel());
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
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Choisir un opérateur',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: Text(
                    'Sélectionnez votre opérateur de paiement préféré',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1.0,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (widget.transactionType ==
                              TransactionType.deposit_momo) {
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
                                  TransactionType.withdraw_momo,
                                  ParamType.Enum,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.04, 16.0, 16.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/wave.png',
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    'Wave',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (widget.transactionType ==
                              TransactionType.deposit_momo) {
                            context.pushNamed(
                              TransactionInitPageWidget.routeName,
                              queryParameters: {
                                'operatorCode': serializeParam(
                                  OperatorCode.FM_SN_CASHOUT,
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
                                  OperatorCode.FM_SN_CASHIN,
                                  ParamType.Enum,
                                ),
                                'transactionType': serializeParam(
                                  TransactionType.withdraw_momo,
                                  ParamType.Enum,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/free-money.png',
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    'Free Money',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xAEFFFFFF),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Image.asset(
                                      'assets/images/wizall.png',
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.contain,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 2.0,
                                          sigmaY: 2.0,
                                        ),
                                        child: Text(
                                          'Indisponible pour le moment',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                            fontFamily: 'Inter Tight',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            shadows: [
                                              Shadow(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 2.0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Wizall Money',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (widget.transactionType ==
                              TransactionType.deposit_momo) {
                            context.pushNamed(
                              TransactionInitPageWidget.routeName,
                              queryParameters: {
                                'operatorCode': serializeParam(
                                  OperatorCode.OM_SN_CASHOUT,
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
                                  OperatorCode.OM_SN_CASHIN,
                                  ParamType.Enum,
                                ),
                                'transactionType': serializeParam(
                                  TransactionType.withdraw_momo,
                                  ParamType.Enum,
                                ),
                              }.withoutNulls,
                            );
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/orangeMoney.png',
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    'Orange Money',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
