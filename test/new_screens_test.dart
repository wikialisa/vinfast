import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/splash_screen.dart';
import 'package:vinfast/screens/onboarding_screen.dart';
import 'package:vinfast/screens/car_remote_screen.dart';
import 'package:vinfast/screens/booking_screen.dart';
import 'package:vinfast/screens/ev_garage_screen.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

Widget _wrap(Widget child, {Map<String, WidgetBuilder>? routes}) {
  return MaterialApp(
    routes: {
      '/onboarding': (_) => const OnboardingScreen(),
      '/login': (_) => const Scaffold(body: Text('Login')),
      '/home': (_) => const Scaffold(body: Text('Home')),
      '/stations': (_) => const Scaffold(body: Text('Stations')),
      ...?routes,
    },
    home: child,
  );
}

void main() {
  // ── SplashScreen ───────────────────────────────────────────────────────────

  group('SplashScreen', () {
    testWidgets('renders VNEGREEN branding', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
      expect(find.text('VNEGREEN'), findsOneWidget);
      expect(find.text('EV Charging · Smart Mobility'), findsOneWidget);
      // Drain the 2-second auto-navigation Timer
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('shows EV station icon', (tester) async {
      await tester.pumpWidget(_wrap(const SplashScreen()));
      expect(find.byIcon(Icons.ev_station), findsOneWidget);
      // Drain the 2-second auto-navigation Timer
      await tester.pump(const Duration(seconds: 3));
    });
  });

  // ── OnboardingScreen ───────────────────────────────────────────────────────
  group('OnboardingScreen', () {
    testWidgets('renders first page title', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      expect(find.text('Sạc nhanh 350 kW'), findsOneWidget);
    });

    testWidgets('shows Tiếp theo button on first page', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      expect(find.text('Tiếp theo'), findsOneWidget);
    });

    testWidgets('shows Bỏ qua button', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      expect(find.text('Bỏ qua'), findsOneWidget);
    });

    testWidgets('Bỏ qua navigates to /login', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      await tester.tap(find.text('Bỏ qua'));
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('tapping Tiếp theo advances page', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      await tester.tap(find.text('Tiếp theo'));
      await tester.pumpAndSettle();
      expect(find.text('Bản đồ thông minh'), findsOneWidget);
    });

    testWidgets('last page shows Bắt đầu button', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      // Advance to page 2
      await tester.tap(find.text('Tiếp theo'));
      await tester.pumpAndSettle();
      // Advance to page 3
      await tester.tap(find.text('Tiếp theo'));
      await tester.pumpAndSettle();
      expect(find.text('Bắt đầu'), findsOneWidget);
    });

    testWidgets('Bắt đầu on last page navigates to /login', (tester) async {
      await tester.pumpWidget(_wrap(const OnboardingScreen()));
      await tester.tap(find.text('Tiếp theo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tiếp theo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bắt đầu'));
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
    });
  });

  // ── CarRemoteScreen ─────────────────────────────────────────────────────────

  group('CarRemoteScreen', () {
    testWidgets('renders AppBar title', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('Điều khiển xe từ xa'), findsOneWidget);
    });

    testWidgets('shows vehicle info', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('VinFast VF 8'), findsOneWidget);
    });

    testWidgets('shows Mở khoá control tile', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('Mở khoá'), findsOneWidget);
    });

    testWidgets('shows Bật AC control tile', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('Bật AC'), findsOneWidget);
    });

    testWidgets('shows Mở nắp sạc control tile', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('Mở nắp sạc'), findsOneWidget);
    });

    testWidgets('shows TPMS section', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      expect(find.text('Áp suất lốp (TPMS)'), findsOneWidget);
    });

    testWidgets('shows all 4 tyre positions', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      await tester.scrollUntilVisible(
          find.text('Sau phải'), 100,
          scrollable: find.byType(Scrollable).first);
      expect(find.text('Trước trái'), findsOneWidget);
      expect(find.text('Sau phải'), findsOneWidget);
    });

    testWidgets('tapping Mở khoá shows loading then toggles', (tester) async {
      await tester.pumpWidget(_wrap(const CarRemoteScreen()));
      await tester.tap(find.text('Mở khoá'));
      await tester.pump();
      // Loading spinner appears
      expect(find.byType(CircularProgressIndicator), findsWidgets);
      // Drain 1.5s async delay
      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pump();
      // Now unlocked — label changes
      expect(find.text('Khoá cửa'), findsOneWidget);
    });
  });

  // ── BookingScreen ───────────────────────────────────────────────────────────

  group('BookingScreen', () {
    testWidgets('renders AppBar title', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      expect(find.text('Đặt trước trạm sạc'), findsOneWidget);
    });

    testWidgets('shows station info (fallback)', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      expect(find.text('VNEGREEN Hub – Demo'), findsOneWidget);
    });

    testWidgets('shows time slot chips', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      expect(find.text('07:00 – 07:15'), findsOneWidget);
    });

    testWidgets('shows deposit amount', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      expect(find.textContaining('50.000đ'), findsOneWidget);
    });

    testWidgets('shows confirm button', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      expect(find.text('Xác nhận đặt chỗ'), findsOneWidget);
    });

    testWidgets('selecting a slot highlights it', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      await tester.tap(find.text('08:00 – 08:15'));
      await tester.pump();
      expect(find.text('08:00 – 08:15'), findsOneWidget);
    });

    testWidgets('confirming booking shows success screen', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      await tester.ensureVisible(find.text('Xác nhận đặt chỗ'));
      await tester.tap(find.text('Xác nhận đặt chỗ'), warnIfMissed: false);
      await tester.pump();
      // Drain 2s async delay
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Đặt chỗ thành công!'), findsOneWidget);
    });

    testWidgets('success screen has go home button', (tester) async {
      await tester.pumpWidget(_wrap(const BookingScreen()));
      await tester.ensureVisible(find.text('Xác nhận đặt chỗ'));
      await tester.tap(find.text('Xác nhận đặt chỗ'), warnIfMissed: false);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Về trang chủ'), findsOneWidget);
    });
  });

  // ── EvGarageScreen ──────────────────────────────────────────────────────────

  group('EvGarageScreen', () {
    testWidgets('renders AppBar title', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      expect(find.text('Garage & Ví sạc'), findsOneWidget);
    });

    testWidgets('shows Xe điện tab', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      expect(find.text('Xe điện'), findsOneWidget);
    });

    testWidgets('shows Ví sạc tab', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      expect(find.text('Ví sạc'), findsOneWidget);
    });

    testWidgets('Garage tab shows VinFast VF 8', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      expect(find.text('VinFast VF 8'), findsOneWidget);
    });

    testWidgets('Garage tab shows SoC 78%', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      expect(find.textContaining('78%'), findsWidgets);
    });

    testWidgets('Garage tab shows battery capacity', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      await tester.scrollUntilVisible(
          find.text('Dung lượng pin'), 100,
          scrollable: find.byType(Scrollable).first);
      expect(find.text('Dung lượng pin'), findsOneWidget);
    });

    testWidgets('switching to Ví sạc tab shows wallet balance', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      await tester.tap(find.text('Ví sạc'));
      await tester.pumpAndSettle();
      expect(find.text('Ví VNEGREEN'), findsOneWidget);
    });

    testWidgets('Ví sạc tab shows top-up buttons', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      await tester.tap(find.text('Ví sạc'));
      await tester.pumpAndSettle();
      expect(find.text('+100.000đ'), findsOneWidget);
      expect(find.text('+200.000đ'), findsOneWidget);
    });

    testWidgets('Ví sạc tab shows charging history', (tester) async {
      await tester.pumpWidget(_wrap(const EvGarageScreen()));
      await tester.tap(find.text('Ví sạc'));
      await tester.pumpAndSettle();
      expect(find.text('Lịch sử sạc gần nhất'), findsOneWidget);
    });
  });
}
