import 'dart:async';
import 'dart:math' show sin, pi;

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'login_model.dart';
import 'custom_numpad.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'Login';
  static String routePath = 'login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  
  bool _isVerifying = false;

  // Failed attempts tracking
  int _failedAttempts = 0;
  int _lockLevel = 0;
  bool _isLocked = false;
  int _lockCountdownSeconds = 0;
  Timer? _lockTimer;
  bool _showError = false;

  // Shake animation
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.pinCodeFocusNode ??= FocusNode();

    _shakeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 100.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.349, 0),
            end: Offset(0, 0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.9, 0.9),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'formOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.05, 1.05),
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 600.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.05, 1.05),
            end: Offset(1.0, 1.0),
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
    _shakeController.dispose();
    _lockTimer?.cancel();
    _model.dispose();

    super.dispose();
  }

  Future<void> _onPinComplete() async {
    if (_isLocked) return;

    setState(() {
      _isVerifying = true;
      _showError = false;
    });

    _model.loginResult = await AuthGroup.loginCall.call(
      phoneNumber: currentUserUid,
      pincode: _model.pinCodeController!.text,
    );

    if ((_model.loginResult?.succeeded ?? true)) {
      // Reset on success
      _failedAttempts = 0;
      _lockLevel = 0;

      GoRouter.of(context).prepareAuthEvent();
      await authManager.signIn(
        authenticationToken:
            UserStruct.maybeFromMap((_model.loginResult?.jsonBody ?? ''))
                ?.access,
        refreshToken:
            UserStruct.maybeFromMap((_model.loginResult?.jsonBody ?? ''))
                ?.refresh,
        authUid:
            UserStruct.maybeFromMap((_model.loginResult?.jsonBody ?? ''))
                ?.phoneNumber,
        userData: UserStruct.maybeFromMap(
            (_model.loginResult?.jsonBody ?? '')),
      );

      context.pushNamedAuth(
        HomeWidget.routeName,
        context.mounted,
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.bottomToTop,
          ),
        },
      );
    } else {
      _failedAttempts++;

      setState(() {
        _isVerifying = false;
        _showError = true;
      });

      // Haptic feedback
      HapticFeedback.heavyImpact();

      // Trigger shake animation
      _shakeController.forward(from: 0.0);

      // Lock if max attempts reached
      if (_failedAttempts >= 3) {
        _lockLevel++;
        _failedAttempts = 0;
        _startLockTimer(_getLockDuration());
      }

      // Clear PIN after shake plays
      await Future.delayed(Duration(milliseconds: 400));
      safeSetState(() {
        _model.pinCodeController?.clear();
      });

      // Reset error color after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _showError = false);
        }
      });
    }

    safeSetState(() {});
  }

  Duration _getLockDuration() {
    switch (_lockLevel) {
      case 1:
        return Duration(seconds: 30);
      case 2:
        return Duration(minutes: 1);
      default:
        return Duration(minutes: 5);
    }
  }

  void _startLockTimer(Duration duration) {
    setState(() {
      _isLocked = true;
      _lockCountdownSeconds = duration.inSeconds;
    });

    _lockTimer?.cancel();
    _lockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _lockCountdownSeconds--;
        if (_lockCountdownSeconds <= 0) {
          _isLocked = false;
          timer.cancel();
        }
      });
    });
  }

  String _formatCountdown(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '${minutes}min ${secs.toString().padLeft(2, '0')}s';
    }
    return '${secs}s';
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
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 670.0,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  
                  // Responsive padding
                  final horizontalPadding = (screenWidth * 0.05).clamp(18.0, 32.0);
                  
                  // Responsive image size
                  final imageSize = (screenWidth * 0.35).clamp(150.0, 250.0);
                  
                  // Responsive PIN field size
                  final pinFieldSize = (screenWidth * 0.12).clamp(50.0, 60.0);
                  
                  // Responsive spacing
                  final topSpacing = (screenHeight * 0.02).clamp(12.0, 24.0);
                  
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          horizontalPadding, 0.0, horizontalPadding, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Ravi de te revoir!',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .displayMedium
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontSize: (screenWidth * 0.065).clamp(24.0, 36.0),
                                    letterSpacing: 0.0,
                                  ),
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation']!),
                            SizedBox(height: topSpacing * 0.5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Fayma_Kash_ouline.png',
                                width: imageSize,
                                height: imageSize * 0.915,
                                fit: BoxFit.cover,
                                alignment: Alignment(0.0, -1.0),
                              ),
                            ),
                            SizedBox(height: topSpacing * 0.5),
                            Text(
                              'Entrez votre code PIN',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: (screenWidth * 0.04).clamp(14.0, 18.0),
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            AnimatedBuilder(
                              animation: _shakeController,
                              builder: (context, child) {
                                final progress = _shakeController.value;
                                final sineValue = sin(progress * pi * 6) * (1 - progress) * 12;
                                return Transform.translate(
                                  offset: Offset(sineValue, 0),
                                  child: child,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: _isVerifying ? 0.5 : (_isLocked ? 0.4 : 1.0),
                                    child: Form(
                                      key: _model.formKey,
                                      autovalidateMode: AutovalidateMode.disabled,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            horizontalPadding, topSpacing, horizontalPadding, 0.0),
                                        child: PinCodeTextField(
                                          autoDisposeControllers: false,
                                          appContext: context,
                                          length: 4,
                                          textStyle: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: (screenWidth * 0.05).clamp(18.0, 24.0),
                                                letterSpacing: 0.0,
                                              ),
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          enableActiveFill: false,
                                          autoFocus: true,
                                          focusNode: _model.pinCodeFocusNode,
                                          enablePinAutofill: false,
                                          errorTextSpace: 16.0,
                                          showCursor: false,
                                          cursorColor: FlutterFlowTheme.of(context).primary,
                                          obscureText: true,
                                          obscuringCharacter: '●',
                                          hintCharacter: '○',
                                          keyboardType: TextInputType.none,
                                          readOnly: true,
                                          pinTheme: PinTheme(
                                            fieldHeight: pinFieldSize,
                                            fieldWidth: pinFieldSize,
                                            borderWidth: 2.0,
                                            borderRadius: BorderRadius.circular(12.0),
                                            shape: PinCodeFieldShape.box,
                                            activeColor: _showError
                                                ? Colors.red
                                                : FlutterFlowTheme.of(context).primary,
                                            inactiveColor: _showError
                                                ? Colors.red.shade300
                                                : FlutterFlowTheme.of(context).alternate,
                                            selectedColor: _showError
                                                ? Colors.red
                                                : FlutterFlowTheme.of(context).primary,
                                          ),
                                          controller: _model.pinCodeController,
                                          onChanged: (_) {},
                                          onCompleted: (_) async {},
                                          autovalidateMode: AutovalidateMode.disabled,
                                          validator: _model.pinCodeControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ).animateOnActionTrigger(
                                        animationsMap['formOnActionTriggerAnimation']!),
                                  ),
                                  if (_isVerifying)
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // Error / remaining attempts / lock message
                            if (_showError || _isLocked || _failedAttempts > 0)
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    if (_isLocked)
                                      Text(
                                        'Trop de tentatives. Réessayez dans ${_formatCountdown(_lockCountdownSeconds)}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.red,
                                              fontSize: (screenWidth * 0.035).clamp(12.0, 14.0),
                                              letterSpacing: 0.0,
                                            ),
                                      )
                                    else if (_showError)
                                      Text(
                                        'Code PIN incorrect ! ${3 - _failedAttempts} tentative${(3 - _failedAttempts) > 1 ? 's' : ''} restante${(3 - _failedAttempts) > 1 ? 's' : ''}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.red,
                                              fontSize: (screenWidth * 0.035).clamp(12.0, 14.0),
                                              letterSpacing: 0.0,
                                            ),
                                      )
                                    else if (_failedAttempts > 0)
                                      Text(
                                        '${3 - _failedAttempts} tentative${(3 - _failedAttempts) > 1 ? 's' : ''} restante${(3 - _failedAttempts) > 1 ? 's' : ''}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              fontSize: (screenWidth * 0.035).clamp(12.0, 14.0),
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      CustomNumpad(
                        onNumberPressed: (number) {
                          if (!_isVerifying && !_isLocked && _model.pinCodeController!.text.length < 4) {
                            setState(() {
                              _model.pinCodeController!.text += number;
                            });
                            if (_model.pinCodeController!.text.length == 4) {
                              if (animationsMap.containsKey('formOnActionTriggerAnimation')) {
                                animationsMap['formOnActionTriggerAnimation']!
                                    .controller
                                    .forward(from: 0.0);
                              }
                              _onPinComplete();
                            }
                          }
                        },
                        onBackspace: () {
                          if (!_isVerifying && !_isLocked && _model.pinCodeController!.text.isNotEmpty) {
                            setState(() {
                              _model.pinCodeController!.text = _model
                                  .pinCodeController!.text
                                  .substring(
                                      0, _model.pinCodeController!.text.length - 1);
                            });
                          }
                        },
                      ),
                      SizedBox(height: (screenHeight * 0.015).clamp(12.0, 20.0)),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          horizontalPadding, 0.0, horizontalPadding, 12.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Le numéro ',
                                style:
                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          fontSize: (screenWidth * 0.035).clamp(12.0, 15.0),
                                          letterSpacing: 0.0,
                                        ),
                              ),
                              TextSpan(
                                text: currentUserUid,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' n\'est pas le vôtre? ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: 'Se déconnecter',
                                style:
                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontSize: (screenWidth * 0.035).clamp(12.0, 15.0),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                mouseCursor: SystemMouseCursors.click,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    GoRouter.of(context).prepareAuthEvent();
                                    await authManager.signOut();
                                    GoRouter.of(context).clearRedirectLocation();
        
                                    context.goNamedAuth(
                                        WelcomeWidget.routeName, context.mounted);
                                  },
                              )
                            ],
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  fontSize: (screenWidth * 0.035).clamp(12.0, 15.0),
                                  letterSpacing: 0.0,
                                ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
