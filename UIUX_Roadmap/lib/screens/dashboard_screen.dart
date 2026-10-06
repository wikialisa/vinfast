import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.primary600,
        elevation: AppTokens.elevationSm,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppColors.primary100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppTokens.spacingMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.show_chart, size: 32, color: Colors.white),
                    Text(
                      '42',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Orders', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: AppTokens.spacingMd,
              runSpacing: AppTokens.spacingMd,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('New Order'),
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: AppColors.secondary600,
                    padding: EdgeInsets.symmetric(
                      vertical: AppTokens.spacingMd,
                      horizontal: AppTokens.spacingLg,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    ),
                  ),
                  onPressed: () {},
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.history),
                  label: const Text('History'),
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: AppColors.secondary600,
                    padding: EdgeInsets.symmetric(
                      vertical: AppTokens.spacingMd,
                      horizontal: AppTokens.spacingLg,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
