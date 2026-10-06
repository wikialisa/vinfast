import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.surface,
              ),
            ),
            const SizedBox(height: AppTokens.spacingMd),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.surface,
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
                // TODO: Implement login logic
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            TextButton(
              onPressed: () {
                // TODO: Navigate to forgot password
              },
              child: const Text('Forgot password?'),
            ),
          ],
        ),
      ),
    );
  }
}
