import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'nfc_reader_popup_model.dart';
export 'nfc_reader_popup_model.dart';

class NfcReaderPopupWidget extends StatefulWidget {
  const NfcReaderPopupWidget({
    super.key,
    required this.nfcState,
    this.amount,
    this.transactionType,
  });

  final NFCState? nfcState;
  final int? amount;
  final TransactionType? transactionType;

  @override
  State<NfcReaderPopupWidget> createState() => _NfcReaderPopupWidgetState();
}

class _NfcReaderPopupWidgetState extends State<NfcReaderPopupWidget> {
  late NfcReaderPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NfcReaderPopupModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.nfcCheckResult = await actions.checkNfc();
      if (_model.nfcCheckResult!) {
        if (widget.nfcState == NFCState.Read) {
          // For Read mode: start timer immediately and wait for scan
          await Future.wait([
            Future(() async {
              try {
                _model.readNfcResult = await actions.readNfc(
                  context,
                );
                // NFC scanned successfully, now processing transaction on server
                _model.isProcessing = true;
                safeSetState(() {});
                
                await action_blocks.executeManagerTransaction(
                  context,
                  transactionType: widget.transactionType,
                  amount: widget.amount,
                  nfcCardIdentifier: _model.readNfcResult,
                );
              } catch (e) {
                print('NFC Reader Widget: Error reading NFC: $e');
                // Error will be shown by timer expiring
              }
            }),
            Future(() async {
              _model.instantTimer = InstantTimer.periodic(
                duration: Duration(milliseconds: 1000),
                callback: (timer) async {
                  _model.timer = _model.timer + -1;
                  safeSetState(() {});
                  if (_model.timer <= 0) {
                    _model.instantTimer?.cancel();
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                startImmediately: true,
              );
            }),
          ]);
        } else {
          // For Emulate mode: show spinner while getting code from server
          _model.isProcessing = true;
          safeSetState(() {});
          
          _model.updateVirtualCardResult =
              await NfcCardGroup.updateVirtualCardIdentifierCall.call(
            authToken: currentAuthenticationToken,
          );

          if ((_model.updateVirtualCardResult?.succeeded ?? true)) {
            // Server responded, now ready for PDA scan - show NFC animation and start timer
            _model.isProcessing = false;
            safeSetState(() {});
            
            await Future.wait([
              Future(() async {
                await actions.startNfcEmulation(
                  context,
                  NfcCardGroup.updateVirtualCardIdentifierCall
                      .virtualCardIdentifier(
                    (_model.updateVirtualCardResult?.jsonBody ?? ''),
                  )!,
                );
                // Card was read by PDA — close the popup
                if (mounted) {
                  _model.instantTimer?.cancel();
                  Navigator.pop(context);
                }
              }),
              Future(() async {
                _model.instantTimer = InstantTimer.periodic(
                  duration: Duration(milliseconds: 1000),
                  callback: (timer) async {
                    _model.timer = _model.timer + -1;
                    safeSetState(() {});
                    if (_model.timer <= 0) {
                      _model.instantTimer?.cancel();
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  startImmediately: true,
                );
              }),
            ]);
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Erreur!'),
                  content: Text(
                      'La carte n\'est sûrement pas valide. Veuillez réessayer !'),
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
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Erreur !'),
              content: Text(
                  'Activez le module NFC! Votre téléphone n\'est peut être pas compatible.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        await actions.stopNfcEmulation();
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    // On component dispose action.
    () async {
      if (widget.nfcState == NFCState.Read) {
        await actions.stopNfcReading();
      } else {
        await actions.stopNfcEmulation();
      }
    }();

    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minWidth: 250.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lecteur NFC',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            _model.isProcessing
                                ? 'Veuillez patienter...'
                                : 'Rapprochez votre téléphone du terminal',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, -1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).accent2,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.contactless,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F8F9),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: _model.isProcessing
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/NfcRead.gif',
                                      width: 250.0,
                                      height: 250.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Text(
                          _model.isProcessing
                              ? (widget.nfcState == NFCState.Read 
                                  ? 'Traitement en cours...'
                                  : 'Récupération du code...')
                              : (widget.nfcState == NFCState.Read
                                  ? 'En attente du scan... (${_model.timer.toString()}s)'
                                  : 'Prêt à scanner... (${_model.timer.toString()}s)'),
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Inter Tight',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Annuler',
                        options: FFButtonOptions(
                          width: 120.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
