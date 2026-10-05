import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/theme/app_tokens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary100,
      body: Center(
        child: Text(
          'Splash',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
