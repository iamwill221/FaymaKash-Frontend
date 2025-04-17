import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'transaction_type_button_model.dart';
export 'transaction_type_button_model.dart';

class TransactionTypeButtonWidget extends StatefulWidget {
  const TransactionTypeButtonWidget({
    super.key,
    required this.icon,
    required this.buttonName,
    this.actionToLaunch,
  });

  final Widget? icon;
  final String? buttonName;
  final Future Function()? actionToLaunch;

  @override
  State<TransactionTypeButtonWidget> createState() =>
      _TransactionTypeButtonWidgetState();
}

class _TransactionTypeButtonWidgetState
    extends State<TransactionTypeButtonWidget> {
  late TransactionTypeButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionTypeButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterFlowIconButton(
          borderRadius: 8.0,
          buttonSize: 40.0,
          fillColor: FlutterFlowTheme.of(context).primary,
          icon: widget.icon!,
          onPressed: () async {
            await widget.actionToLaunch?.call();
          },
        ),
        Text(
          valueOrDefault<String>(
            widget.buttonName,
            'Text',
          ),
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Inter',
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }
}
