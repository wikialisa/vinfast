import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/charging_session_screen.dart';
import 'package:vinfast/screens/charging_station_search_screen.dart';

const _demoStation = ChargingStation(
  id: 'test01',
  name: 'Test Hub',
  address: '1 Test Street',
  distanceKm: 0.5,
  availablePorts: 2,
  totalPorts: 4,
  powerKw: 150,
  connectorType: 'CCS2',
  pricePerKwh: 3500,
  rating: 4.9,
);

Widget _wrap({ChargingStation? station}) => MaterialApp(
      routes: {
        '/home': (_) => const Scaffold(body: Text('Home')),
      },
      home: ChargingSessionScreen(station: station ?? _demoStation),
    );

void main() {
  group('ChargingSessionScreen – idle view', () {
    testWidgets('shows AppBar title "Charging Session"', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Charging Session'), findsOneWidget);
    });

    testWidgets('shows station name in hero card', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Test Hub'), findsOneWidget);
    });

    testWidgets('shows station address', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('1 Test Street'), findsOneWidget);
    });

    testWidgets('shows connector type badge', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('CCS2'), findsOneWidget);
    });

    testWidgets('shows power kW badge', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.textContaining('150 kW'), findsWidgets);
    });

    testWidgets('shows Payment Pre-Auth section', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Payment Pre‑Auth'), findsOneWidget);
    });

    testWidgets('shows pre-auth escrow amount 200.000đ', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.textContaining('200.000đ'), findsOneWidget);
    });

    testWidgets('shows card placeholder "Visa •••• 4242"', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Visa •••• 4242'), findsOneWidget);
    });

    testWidgets('"Start Charging" button present', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Start Charging'), findsOneWidget);
    });
  });

  group('ChargingSessionScreen – session start', () {
    testWidgets('tapping Start Charging shows pre-auth loading', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      await tester.pump();
      expect(find.text('Authorising payment…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Drain pre-auth timer
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('after pre-auth completes, shows charging view', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Stop Charging'), findsOneWidget);
    });

    testWidgets('charging view shows 0.0 kWh initially', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.textContaining('0.0 kWh'), findsOneWidget);
    });

    testWidgets('kWh increments after charging timer tick', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      // pre-auth 2s + 1 tick 3s = 5s
      await tester.pump(const Duration(seconds: 6));
      await tester.pump();
      expect(find.textContaining('0.5 kWh'), findsOneWidget);
    });
  });

  group('ChargingSessionScreen – stop & receipt', () {
    Future<void> _getToCharging(WidgetTester tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
    }

    testWidgets('tapping Stop Charging shows finalising phase', (tester) async {
      await _getToCharging(tester);
      await tester.tap(find.text('Stop Charging'));
      await tester.pump();
      expect(find.text('Finalising payment…'), findsOneWidget);
      // Drain capture timer
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('receipt view shows after stop completes', (tester) async {
      await _getToCharging(tester);
      await tester.tap(find.text('Stop Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Charging Complete!'), findsOneWidget);
    });

    testWidgets('receipt shows station name', (tester) async {
      await _getToCharging(tester);
      await tester.tap(find.text('Stop Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Test Hub'), findsOneWidget);
    });

    testWidgets('receipt shows Share and Done buttons', (tester) async {
      await _getToCharging(tester);
      await tester.tap(find.text('Stop Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('tapping Done navigates to /home', (tester) async {
      await _getToCharging(tester);
      await tester.tap(find.text('Stop Charging'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('ChargingSessionScreen – default station fallback', () {
    testWidgets('renders with no station prop (uses demo default)',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const ChargingSessionScreen(),
      ));
      expect(find.text('VNEGREEN Hub – Demo'), findsOneWidget);
    });
  });
}
