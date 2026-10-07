import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/battery_detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/remote_control_screen.dart';
import 'screens/charging_station_search_screen.dart';
import 'screens/charging_session_screen.dart';
import 'screens/car_remote_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/ev_garage_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_tokens.dart';

void main() {
  runApp(const VinFastApp());
}

class VinFastApp extends StatelessWidget {
  const VinFastApp({super.key});

  static ThemeData _buildTheme({required bool dark}) {
    final bg = dark ? AppColors.darkBackground : AppColors.background;
    final surf = dark ? AppColors.darkSurface : AppColors.surface;
    final onBg = dark ? AppColors.darkOnBackground : AppColors.onBackground;
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: dark ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: bg,
      fontFamily: AppTokens.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: dark ? AppColors.darkSurface : AppColors.primary600,
        foregroundColor:
            dark ? AppColors.darkOnBackground : AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
        titleTextStyle: TextStyle(
          fontFamily: AppTokens.fontFamily,
          fontSize: AppTokens.fontSizeMD,
          fontWeight: AppTokens.fontWeightSemiBold,
          color: dark ? AppColors.darkOnBackground : AppColors.onPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary600,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusSm),
          ),
          elevation: AppTokens.elevation2,
        ),
      ),
      cardTheme: CardThemeData(
        color: dark ? AppColors.darkCard : surf,
        elevation: AppTokens.elevation2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: AppTokens.fontFamily,
          fontSize: AppTokens.fontSizeSM,
          color: onBg,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VNEGREEN',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(dark: false),
      darkTheme: _buildTheme(dark: true),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/otp': (_) => const OtpScreen(),
        '/home': (_) => const HomeScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/battery': (_) => const BatteryDetailScreen(),
        '/map': (_) => const MapScreen(),
        '/remote': (_) => const RemoteControlScreen(),
        '/car-remote': (_) => const CarRemoteScreen(),
        '/stations': (_) => const ChargingStationSearchScreen(),
        '/charging-session': (ctx) => ChargingSessionScreen(
              station:
                  ModalRoute.of(ctx)!.settings.arguments as ChargingStation?,
            ),
        '/booking': (ctx) => BookingScreen(
              station:
                  ModalRoute.of(ctx)?.settings.arguments as ChargingStation?,
            ),
        '/garage': (_) => const EvGarageScreen(),
      },
    );
  }
}
