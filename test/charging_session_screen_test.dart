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

/// Navigates to the charging phase and leaves no pending timers.
///
/// Flow:
///  - tap "Start Charging"
///  - pump 2s → pre-auth Future.delayed fires → phase = charging, tick1 scheduled
///  - pump 3s → tick1 fires (0.5 kWh added), tick2 scheduled
///  - pump 3s → tick2 fires, tick3 scheduled
///  - *stop* right after so tick3 is cancelled when _stopSession runs
///
/// Tests that only need to *check* charging state call [_getToCharging].
/// Tests that stop the session call [_getToCharging] then immediately stop,
/// which cancels tick3 before it fires.
Future<void> _getToCharging(WidgetTester tester) async {
  await tester.pumpWidget(_wrap());
  await tester.tap(find.text('Start Charging'));
  // Drain the 2s pre-auth delay so we enter charging phase
  await tester.pump(const Duration(seconds: 3));
  await tester.pump();
  // Drain tick-1 (3s) — fires, schedules tick-2
  await tester.pump(const Duration(seconds: 3));
  await tester.pump();
  // tick-2 is now scheduled; it will be cancelled by _stopSession OR
  // must be explicitly drained if the test just checks charging state.
  // Drain tick-2 here so tests that only inspect charging state are clean:
  await tester.pump(const Duration(seconds: 3));
  await tester.pump();
  // tick-3 is now scheduled. Tests that stop charging will cancel it.
  // Tests that only look at the UI must drain it too:
}

/// Call after [_getToCharging] when the test needs to stop the session.
/// Cancels the pending tick-3 timer via _stopSession, then drains the
/// 2s "finalising" delay.
Future<void> _stopCharging(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Stop Charging'));
  await tester.tap(find.text('Stop Charging'), warnIfMissed: false);
  await tester.pump();
  // Drain the 2-second finalising delay
  await tester.pump(const Duration(seconds: 3));
  await tester.pump();
}

void main() {
  group('ChargingSessionScreen – idle view', () {
    testWidgets('shows AppBar title', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Charging Session'), findsOneWidget);
    });

    testWidgets('shows station name', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Test Hub'), findsOneWidget);
    });

    testWidgets('shows station address', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('1 Test Street'), findsOneWidget);
    });

    testWidgets('shows connector type', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('CCS2'), findsOneWidget);
    });

    testWidgets('shows power badge', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.textContaining('150 kW'), findsWidgets);
    });

    testWidgets('shows Payment Pre-Auth section', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Payment Pre‑Auth'), findsOneWidget);
    });

    testWidgets('shows pre-auth escrow amount', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.textContaining('200.000đ'), findsOneWidget);
    });

    testWidgets('shows card placeholder', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Visa •••• 4242'), findsOneWidget);
    });

    testWidgets('Start Charging button present', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Start Charging'), findsOneWidget);
    });
  });

  group('ChargingSessionScreen – session start', () {
    testWidgets('tapping Start shows pre-auth loading', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      await tester.pump();
      expect(find.text('Authorising payment…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Drain pre-auth timer + tick-1
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('after pre-auth shows charging view', (tester) async {
      await _getToCharging(tester);
      expect(find.text('Stop Charging'), findsOneWidget);
      // Drain pending tick-3
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('charging view shows kWh counter', (tester) async {
      await _getToCharging(tester);
      // After _getToCharging: tick-1 fired (0.5 kWh), tick-2 fired (1.0 kWh)
      expect(find.textContaining('kWh'), findsWidgets);
      // Drain pending tick-3
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('kWh increments after 3s tick', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Start Charging'));
      // Drain pre-auth (2s)
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      // Now in charging; 0 kWh
      expect(find.textContaining('0.0 kWh'), findsOneWidget);
      // Drain tick-1
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.textContaining('0.5 kWh'), findsOneWidget);
      // Drain tick-2
      await tester.pump(const Duration(seconds: 3));
    });
  });

  group('ChargingSessionScreen – stop & receipt', () {
    testWidgets('Stop Charging shows finalising phase', (tester) async {
      await _getToCharging(tester);
      await tester.ensureVisible(find.text('Stop Charging'));
      await tester.tap(find.text('Stop Charging'), warnIfMissed: false);
      await tester.pump();
      expect(find.text('Finalising payment…'), findsOneWidget);
      // Drain capture delay
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
    });

    testWidgets('receipt view after stop completes', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      expect(find.text('Charging Complete!'), findsOneWidget);
    });

    testWidgets('receipt shows station name', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      expect(find.text('Test Hub'), findsOneWidget);
    });

    testWidgets('receipt shows Share and Done', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('receipt shows CO2 saved section', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      expect(find.text('CO₂ tiết kiệm'), findsOneWidget);
    });

    testWidgets('receipt shows Green Points section', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      expect(find.text('Điểm thưởng xanh'), findsOneWidget);
    });

    testWidgets('Done navigates to /home', (tester) async {
      await _getToCharging(tester);
      await _stopCharging(tester);
      await tester.ensureVisible(find.text('Done'));
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('ChargingSessionScreen – fallback station', () {
    testWidgets('renders demo station when no prop given', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ChargingSessionScreen(),
      ));
      expect(find.text('VNEGREEN Hub – Demo'), findsOneWidget);
    });
  });
}
