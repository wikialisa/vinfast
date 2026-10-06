import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/onboarding1.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.directions_car,
                  size: 120,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            const Text(
              'Welcome to VinFast',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            const Text(
              'Discover features that help you stay connected to your vehicle.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  vertical: AppTokens.spacingMd,
                ),
              ),
              onPressed: () {
                // TODO: Navigate to next onboarding screen
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
