import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class RemoteControlScreen extends StatelessWidget {
  const RemoteControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Control'),
        backgroundColor: AppColors.primary600,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppTokens.spacingMd,
          mainAxisSpacing: AppTokens.spacingMd,
          children: const [
            _RemoteButton(icon: Icons.lock, label: 'Lock/Unlock'),
            _RemoteButton(icon: Icons.lightbulb, label: 'Lights'),
            _RemoteButton(icon: Icons.ac_unit, label: 'Climate'),
            _RemoteButton(icon: Icons.campaign, label: 'Horn'),
          ],
        ),
      ),
    );
  }
}

class _RemoteButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _RemoteButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 32),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary600,
        padding: const EdgeInsets.symmetric(vertical: AppTokens.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSm),
        ),
      ),
      onPressed: () {},
    );
  }
}
