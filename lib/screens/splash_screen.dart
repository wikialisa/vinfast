import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

/// Màn hình Splash — tự động chuyển sang Onboarding sau 2 giây.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary700,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
              ),
              child: const Icon(
                Icons.ev_station,
                size: 56,
                color: AppColors.primary700,
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            const Text(
              'VNEGREEN',
              style: TextStyle(
                fontSize: AppTokens.fontSizeXXL,
                fontWeight: AppTokens.fontWeightBold,
                color: AppColors.onPrimary,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: AppTokens.spacing2),
            const Text(
              'EV Charging · Smart Mobility',
              style: TextStyle(
                fontSize: AppTokens.fontSizeSM,
                fontWeight: AppTokens.fontWeightRegular,
                color: AppColors.primary100,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
