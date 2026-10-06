// lib/vinfast_core/widgets/common.dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_tokens.dart';

/// A simple scaffold wrapper used by all prototype screens.
/// It applies the design‑system colours and spacing automatically.
class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  const BaseScreen({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary600,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(AppTokens.spacingLg),
        child: child,
      ),
    );
  }
}
