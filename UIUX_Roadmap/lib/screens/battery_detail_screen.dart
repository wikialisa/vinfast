import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class BatteryDetailScreen extends StatelessWidget {
  const BatteryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Detail'),
        backgroundColor: AppColors.primary600,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
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
                child: Column(
                  children: const [
                    Text(
                      'Battery Level',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    LinearProgressIndicator(value: 0.78, minHeight: 8),
                    SizedBox(height: 8),
                    Text(
                      '78% (45 km range)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                // ignore: deprecated_member_use
                primary: AppColors.secondary600,
                padding: EdgeInsets.symmetric(vertical: AppTokens.spacingMd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
