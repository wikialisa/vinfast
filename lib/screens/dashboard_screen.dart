import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppTokens.spacingMd),
            child: VfChip(label: 'Online', showDot: true),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Vehicle hero card ──────────────────────────────────────────
            VfCard(
              color: AppColors.primary700,
              child: Row(
                children: [
                  const Icon(Icons.directions_car,
                      size: 64, color: AppColors.onPrimary),
                  const SizedBox(width: AppTokens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VinFast VF 8',
                            style: AppTypography.h3
                                .copyWith(color: AppColors.onPrimary)),
                        const SizedBox(height: AppTokens.spacing1),
                        Text('51A – 123.45',
                            style: AppTypography.caption
                                .copyWith(color: AppColors.primary100)),
                      ],
                    ),
                  ),
                  const VfChip(label: 'Locked'),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spacingMd),

            // ── Metric tiles grid ──────────────────────────────────────────
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: AppTokens.spacingMd,
              mainAxisSpacing: AppTokens.spacingMd,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                VfInfoTile(
                  icon: Icons.battery_charging_full,
                  value: '78%',
                  label: 'Battery',
                  iconColor: AppColors.secondary600,
                ),
                VfInfoTile(
                  icon: Icons.speed,
                  value: '45 km',
                  label: 'Range',
                ),
                VfInfoTile(
                  icon: Icons.thermostat,
                  value: '24 °C',
                  label: 'Cabin Temp',
                ),
                VfInfoTile(
                  icon: Icons.route,
                  value: '12,430',
                  label: 'Total km',
                ),
              ],
            ),
            const SizedBox(height: AppTokens.spacingMd),

            // ── Quick actions ──────────────────────────────────────────────
            const Text('Quick Actions', style: AppTypography.h4),
            const SizedBox(height: AppTokens.spacingSm),
            Row(
              children: [
                Expanded(
                  child: VfButton.secondary(
                    label: 'Find Station',
                    icon: Icons.ev_station,
                    onPressed: () => Navigator.pushNamed(context, '/stations'),
                  ),
                ),
                const SizedBox(width: AppTokens.spacingMd),
                Expanded(
                  child: VfButton.outlined(
                    label: 'Battery',
                    icon: Icons.battery_charging_full,
                    onPressed: () => Navigator.pushNamed(context, '/battery'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
