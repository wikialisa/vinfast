import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';
import 'dashboard_screen.dart';
import 'map_screen.dart';
import 'remote_control_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<_TabItem> _tabs = [
    _TabItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Dashboard'),
    _TabItem(icon: Icons.map_outlined, activeIcon: Icons.map, label: 'Map'),
    _TabItem(
        icon: Icons.settings_remote_outlined,
        activeIcon: Icons.settings_remote,
        label: 'Remote'),
    _TabItem(
        icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  final List<Widget> _screens = const [
    DashboardScreen(),
    MapScreen(),
    RemoteControlScreen(),
    _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: AppColors.primary600,
        unselectedItemColor: AppColors.onSurface,
        selectedLabelStyle: AppTypography.caption.copyWith(
          color: AppColors.primary600,
          fontWeight: AppTokens.fontWeightMedium,
        ),
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        elevation: AppTokens.elevation4,
        items: _tabs
            .map((t) => BottomNavigationBarItem(
                  icon: Icon(t.icon),
                  activeIcon: Icon(t.activeIcon),
                  label: t.label,
                ))
            .toList(),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _TabItem(
      {required this.icon, required this.activeIcon, required this.label});
}

/// Placeholder profile tab shown in the bottom nav.
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
      body: const Padding(
        padding: EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary100,
              child: Icon(Icons.person, size: 48, color: AppColors.primary700),
            ),
            SizedBox(height: AppTokens.spacingMd),
            VfCard(
              child: ListTile(
                leading: Icon(Icons.directions_car,
                    color: AppColors.primary600),
                title: Text('My Vehicle', style: AppTypography.h4),
                subtitle: Text('VinFast VF 8', style: AppTypography.caption),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            SizedBox(height: AppTokens.spacingSm),
            VfCard(
              child: ListTile(
                leading: Icon(Icons.notifications_outlined,
                    color: AppColors.primary600),
                title: Text('Notifications', style: AppTypography.h4),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
