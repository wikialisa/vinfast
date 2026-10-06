import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/battery_detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/remote_control_screen.dart';

void main() {
  runApp(const VinFastApp());
}

class VinFastApp extends StatelessWidget {
  const VinFastApp({super.key});

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
