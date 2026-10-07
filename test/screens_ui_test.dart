import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/login_screen.dart';
import 'package:vinfast/screens/dashboard_screen.dart';
import 'package:vinfast/screens/home_screen.dart';

void main() {
  // ── LoginScreen ───────────────────────────────────────────────────────────

  group('LoginScreen – render', () {
    Widget loginWrap() => const MaterialApp(
          home: LoginScreen(),
        );

    testWidgets('shows VinFast brand text', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.text('VinFast'), findsOneWidget);
      expect(find.text('Companion'), findsOneWidget);
    });

    testWidgets('shows electric car icon', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.byIcon(Icons.electric_car), findsOneWidget);
    });

    testWidgets('shows Email input field', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    });

    testWidgets('shows Password input field', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    });

    testWidgets('shows Sign In button', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('shows Forgot password link', (tester) async {
      await tester.pumpWidget(loginWrap());
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('Password field has obscureText enabled', (tester) async {
      await tester.pumpWidget(loginWrap());
      final passwordField = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Password'),
      );
      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('Sign In button navigates to /home', (tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/home': (_) => const Scaffold(body: Text('Home')),
        },
        home: const LoginScreen(),
      ));
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });
  });

  // ── DashboardScreen ───────────────────────────────────────────────────────

  group('DashboardScreen – render', () {
    Widget dashWrap() => MaterialApp(
          routes: {
            '/stations': (_) => const Scaffold(body: Text('Stations')),
            '/battery': (_) => const Scaffold(body: Text('Battery')),
          },
          home: const DashboardScreen(),
        );

    testWidgets('shows AppBar title "Dashboard"', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('shows Online status chip', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('Online'), findsOneWidget);
    });

    testWidgets('shows vehicle name in hero card', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('VinFast VF 8'), findsOneWidget);
    });

    testWidgets('shows licence plate', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.textContaining('51A'), findsOneWidget);
    });

    testWidgets('shows Battery metric tile', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('78%'), findsOneWidget);
      // 'Battery' appears in the metric tile AND the quick-action button label
      expect(find.text('Battery'), findsWidgets);
    });

    testWidgets('shows Range metric tile', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('45 km'), findsOneWidget);
      expect(find.text('Range'), findsOneWidget);
    });

    testWidgets('shows Cabin Temp tile', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('24 °C'), findsOneWidget);
    });

    testWidgets('shows Total km tile', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('12,430'), findsOneWidget);
    });

    testWidgets('shows Quick Actions section', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('Quick Actions'), findsOneWidget);
    });

    testWidgets('Find Station button is present', (tester) async {
      await tester.pumpWidget(dashWrap());
      // Button may be below viewport; just confirm it exists in the tree
      expect(find.text('Find Station'), findsOneWidget);
    });

    testWidgets('Battery button is present', (tester) async {
      await tester.pumpWidget(dashWrap());
      expect(find.text('Battery'), findsWidgets);
    });

    testWidgets('Find Station button navigates to /stations', (tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/stations': (_) => const Scaffold(body: Text('StationsPage')),
          '/battery': (_) => const Scaffold(body: Text('BatteryPage')),
        },
        home: const DashboardScreen(),
      ));
      await tester.ensureVisible(find.text('Find Station'));
      await tester.tap(find.text('Find Station'), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('StationsPage'), findsOneWidget);
    });

    testWidgets('Battery button navigates to /battery', (tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/stations': (_) => const Scaffold(body: Text('StationsPage')),
          '/battery': (_) => const Scaffold(body: Text('BatteryPage')),
        },
        home: const DashboardScreen(),
      ));
      await tester.ensureVisible(find.widgetWithText(OutlinedButton, 'Battery'));
      await tester.tap(find.widgetWithText(OutlinedButton, 'Battery'),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('BatteryPage'), findsOneWidget);
    });
  });

  // ── HomeScreen ────────────────────────────────────────────────────────────

  group('HomeScreen – bottom navigation', () {
    Widget homeWrap() => const MaterialApp(home: HomeScreen());

    testWidgets('shows 4 bottom nav items', (tester) async {
      await tester.pumpWidget(homeWrap());
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      // 'Dashboard' appears in BottomNav label AND DashboardScreen AppBar title
      expect(find.text('Dashboard'), findsWidgets);
      // 'Map' appears in BottomNav label AND MapScreen AppBar title
      expect(find.text('Map'), findsWidgets);
      expect(find.text('Remote'), findsWidgets);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('initially shows Dashboard tab content', (tester) async {
      await tester.pumpWidget(homeWrap());
      // DashboardScreen is the first child — its AppBar title is visible
      expect(find.text('Dashboard'), findsWidgets);
    });

    testWidgets('tapping Map tab shows Map content', (tester) async {
      await tester.pumpWidget(homeWrap());
      await tester.tap(find.text('Map'));
      await tester.pump();
      expect(find.text('Map view placeholder'), findsOneWidget);
    });

    testWidgets('tapping Remote tab shows Remote Control content',
        (tester) async {
      await tester.pumpWidget(homeWrap());
      await tester.tap(find.text('Remote'));
      await tester.pump();
      expect(find.text('Lock/Unlock'), findsOneWidget);
    });

    testWidgets('tapping Profile tab shows Profile content', (tester) async {
      await tester.pumpWidget(homeWrap());
      await tester.tap(find.text('Profile'));
      await tester.pump();
      expect(find.text('My Vehicle'), findsOneWidget);
    });

    testWidgets('switching tabs does not recreate state (IndexedStack)',
        (tester) async {
      await tester.pumpWidget(homeWrap());
      // Switch to Map and back to Dashboard
      await tester.tap(find.text('Map'));
      await tester.pump();
      await tester.tap(find.text('Dashboard'));
      await tester.pump();
      // Dashboard still shows
      expect(find.text('VinFast VF 8'), findsOneWidget);
    });
  });
}
