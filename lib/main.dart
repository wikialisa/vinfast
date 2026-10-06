import 'package:flutter/material.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/splash_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/onboarding_screen1.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/login_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/home_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/dashboard_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/battery_detail_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/map_screen.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/remote_control_screen.dart';

void main() {
  runApp(const VinFastApp());
}

class VinFastApp extends StatelessWidget {
  const VinFastApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VinFast Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF336699)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen1(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/battery': (_) => const BatteryDetailScreen(),
        '/map': (_) => const MapScreen(),
        '/remote': (_) => const RemoteControlScreen(),
      },
    );
  }
}
