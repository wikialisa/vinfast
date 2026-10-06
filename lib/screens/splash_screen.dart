import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary100,
      body: Center(
        child: Text(
          'VinFast',
          style: TextStyle(
            fontSize: AppTokens.fontSizeXXL,
            fontWeight: FontWeight.bold,
            color: AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
