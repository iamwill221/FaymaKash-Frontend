import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_list_widget_model.dart';
export 'empty_list_widget_model.dart';

/// Empty list of transactions widgets
class EmptyListWidgetWidget extends StatefulWidget {
  const EmptyListWidgetWidget({super.key});

  @override
  State<EmptyListWidgetWidget> createState() => _EmptyListWidgetWidgetState();
}

class _EmptyListWidgetWidgetState extends State<EmptyListWidgetWidget> {
  late EmptyListWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyListWidgetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 44.0,
              ),
              Text(
                'Pas de transactions trouvés',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Inter Tight',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
              Text(
                'Une fois que vous commencerez à faire des transactions vous allez trouver la liste ici',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                    ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
