import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/charging_station_search_screen.dart';

void main() {
  Widget _wrap() => const MaterialApp(
        home: ChargingStationSearchScreen(),
      );

  group('ChargingStationSearchScreen – render', () {
    testWidgets('shows AppBar title', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.text('Find Charging Station'), findsOneWidget);
    });

    testWidgets('shows search TextField', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(
        find.widgetWithText(TextField, '').evaluate().isNotEmpty ||
            find.byType(TextField).evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('shows connector filter chips', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.byType(FilterChip), findsWidgets);
      expect(find.text('All'), findsOneWidget);
      // CCS2 and Type 2 appear in both chips and station tile badges
      expect(find.text('CCS2'), findsWidgets);
      expect(find.text('Type 2'), findsWidgets);
    });

    testWidgets('shows all 5 demo stations by default', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pump();
      expect(find.text('5 stations found'), findsOneWidget);
    });

    testWidgets('renders station names from fixture data', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pump();
      expect(find.textContaining('VNEGREEN Hub'), findsOneWidget);
      expect(find.textContaining('Tesla Supercharger'), findsOneWidget);
    });
  });

  group('ChargingStationSearchScreen – search', () {
    testWidgets('filtering by text reduces station count', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.enterText(find.byType(TextField).first, 'Tesla');
      await tester.pump();
      expect(find.text('1 station found'), findsOneWidget);
    });

    testWidgets('empty search restores all results', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.enterText(find.byType(TextField).first, 'xyz_no_match');
      await tester.pump();
      expect(find.text('0 stations found'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, '');
      await tester.pump();
      expect(find.text('5 stations found'), findsOneWidget);
    });

    testWidgets('clear icon button removes query', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.enterText(find.byType(TextField).first, 'Hub');
      await tester.pump();
      // Clear button (suffix icon) appears
      expect(find.byIcon(Icons.clear), findsOneWidget);
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      expect(find.text('5 stations found'), findsOneWidget);
    });
  });

  group('ChargingStationSearchScreen – connector filter', () {
    testWidgets('selecting CCS2 chip filters stations', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('CCS2'));
      await tester.pump();
      // Only CCS2 stations (vn001, vn004) → 2
      expect(find.text('2 stations found'), findsOneWidget);
    });

    testWidgets('selecting Tesla chip shows 1 station', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('Tesla'));
      await tester.pump();
      expect(find.text('1 station found'), findsOneWidget);
    });

    testWidgets('selecting All chip restores all results', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('CCS2'));
      await tester.pump();
      await tester.tap(find.text('All'));
      await tester.pump();
      expect(find.text('5 stations found'), findsOneWidget);
    });
  });

  group('ChargingStationSearchScreen – power filter', () {
    testWidgets('selecting ≥150 kW shows correct stations', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('≥150 kW'));
      await tester.pump();
      // vn001 (150), vn004 (150), Tesla (250) → 3
      expect(find.text('3 stations found'), findsOneWidget);
    });

    testWidgets('selecting Any restores all', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.tap(find.text('≥150 kW'));
      await tester.pump();
      await tester.tap(find.text('Any'));
      await tester.pump();
      expect(find.text('5 stations found'), findsOneWidget);
    });
  });

  group('ChargingStationSearchScreen – empty state', () {
    testWidgets('shows empty state when no stations match', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.enterText(find.byType(TextField).first, 'ZZZ_NOT_EXIST');
      await tester.pump();
      expect(find.text('No stations found'), findsOneWidget);
      expect(find.text('Try adjusting your filters'), findsOneWidget);
    });
  });

  group('ChargingStationSearchScreen – station tile', () {
    testWidgets('station tile shows availability chip', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pump();
      // vn001 has 4 free ports → "4 free"
      expect(find.text('4 free'), findsOneWidget);
    });

    testWidgets('full station shows "Full" chip', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pump();
      // vn003 has 0 available ports → "Full"
      expect(find.text('Full'), findsOneWidget);
    });

    testWidgets('map action button in AppBar is present', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.byIcon(Icons.map_outlined), findsOneWidget);
    });
  });
}
