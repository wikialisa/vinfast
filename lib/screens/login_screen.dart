import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacingLg,
            vertical: AppTokens.spacing9,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Logo ────────────────────────────────────────────────────
              const Icon(
                Icons.electric_car,
                size: 72,
                color: AppColors.primary600,
              ),
              const SizedBox(height: AppTokens.spacingMd),
              Text(
                'VinFast',
                textAlign: TextAlign.center,
                style: AppTypography.h1.copyWith(color: AppColors.primary700),
              ),
              Text(
                'Companion',
                textAlign: TextAlign.center,
                style: AppTypography.h3.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: AppTokens.spacing9),

              // ── Form ─────────────────────────────────────────────────────
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    borderSide:
                        const BorderSide(color: AppColors.primary600, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.spacingMd),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    borderSide:
                        const BorderSide(color: AppColors.primary600, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.spacingLg),

              VfButton(
                label: 'Sign In',
                icon: Icons.login,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(height: AppTokens.spacingSm),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: AppTypography.body
                        .copyWith(color: AppColors.primary600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
