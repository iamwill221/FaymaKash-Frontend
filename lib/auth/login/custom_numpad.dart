import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class CustomNumpad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometricPressed;

  const CustomNumpad({
    super.key,
    required this.onNumberPressed,
    required this.onBackspace,
    this.onBiometricPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive values based on screen size
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.015; // 1.5% of screen height
    final buttonSpacing = screenHeight * 0.012; // 1.2% of screen height
    final buttonHorizontalPadding = screenWidth * 0.018; // 1.8% of screen width
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.clamp(16.0, 32.0),
        vertical: verticalPadding.clamp(12.0, 20.0),
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNumberRow(['1', '2', '3'], context, buttonHorizontalPadding),
          SizedBox(height: buttonSpacing.clamp(8.0, 14.0)),
          _buildNumberRow(['4', '5', '6'], context, buttonHorizontalPadding),
          SizedBox(height: buttonSpacing.clamp(8.0, 14.0)),
          _buildNumberRow(['7', '8', '9'], context, buttonHorizontalPadding),
          SizedBox(height: buttonSpacing.clamp(8.0, 14.0)),
          _buildBottomRow(context, buttonHorizontalPadding),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers, BuildContext context, double horizontalPadding) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) => _buildNumberButton(number, context, horizontalPadding)).toList(),
    );
  }

  Widget _buildNumberButton(String number, BuildContext context, double horizontalPadding) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive button height (6-8% of screen height, clamped between 48 and 64)
    final buttonHeight = (screenHeight * 0.07).clamp(52.0, 68.0);
    
    // Responsive text size
    final textSize = (screenWidth * 0.065).clamp(22.0, 32.0);
    
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding.clamp(4.0, 8.0)),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          elevation: 0,
          child: InkWell(
            onTap: () => onNumberPressed(number),
            borderRadius: BorderRadius.circular(12.0),
            splashColor: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
            highlightColor: FlutterFlowTheme.of(context).primary.withOpacity(0.05),
            child: Container(
              height: buttonHeight,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  number,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Inter Tight',
                        fontSize: textSize,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context, double horizontalPadding) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive button height
    final buttonHeight = (screenHeight * 0.07).clamp(52.0, 68.0);
    
    // Responsive icon sizes
    final fingerprintSize = (screenWidth * 0.075).clamp(26.0, 36.0);
    final backspaceSize = (screenWidth * 0.065).clamp(22.0, 32.0);
    final textSize = (screenWidth * 0.065).clamp(22.0, 32.0);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Biometric button (left)
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.clamp(4.0, 8.0)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 0,
              child: InkWell(
                onTap: onBiometricPressed,
                borderRadius: BorderRadius.circular(12.0),
                splashColor: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                highlightColor: FlutterFlowTheme.of(context).primary.withOpacity(0.05),
                child: Container(
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: onBiometricPressed != null
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    border: onBiometricPressed != null
                        ? Border.all(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          )
                        : null,
                  ),
                  child: onBiometricPressed != null
                      ? Center(
                          child: Icon(
                            Icons.fingerprint,
                            size: fingerprintSize,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
        // Zero button (center)
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.clamp(4.0, 8.0)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 0,
              child: InkWell(
                onTap: () => onNumberPressed('0'),
                borderRadius: BorderRadius.circular(12.0),
                splashColor: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                highlightColor: FlutterFlowTheme.of(context).primary.withOpacity(0.05),
                child: Container(
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '0',
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Inter Tight',
                            fontSize: textSize,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Backspace button (right)
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.clamp(4.0, 8.0)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 0,
              child: InkWell(
                onTap: onBackspace,
                borderRadius: BorderRadius.circular(12.0),
                splashColor: FlutterFlowTheme.of(context).error.withOpacity(0.1),
                highlightColor: FlutterFlowTheme.of(context).error.withOpacity(0.05),
                child: Container(
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.backspace_outlined,
                      size: backspaceSize,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
