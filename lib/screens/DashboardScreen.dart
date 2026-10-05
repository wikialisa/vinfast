import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/theme/app_tokens.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary100,
        title: const Text('Dashboard'),
        foregroundColor: AppColors.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppTokens.spacingSm,
          mainAxisSpacing: AppTokens.spacingSm,
          children: List.generate(4, (index) {
            return Card(
              color: AppColors.surface,
              child: Center(
                child: Text(
                  'Widget ${index + 1}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
