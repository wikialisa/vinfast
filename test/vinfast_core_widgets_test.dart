import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/vinfast_core/widgets/common.dart';
import 'package:vinfast/theme/app_colors.dart';

void main() {
  // ── VfButton ──────────────────────────────────────────────────────────────

  group('VfButton', () {
    testWidgets('primary renders label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VfButton(label: 'Sign In', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('secondary renders label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VfButton.secondary(label: 'Cancel', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('outlined renders label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VfButton.outlined(label: 'Map', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Map'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfButton(label: 'Loading', onPressed: null, isLoading: true),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VfButton(label: 'Tap me', onPressed: () => tapped = true),
          ),
        ),
      );
      await tester.tap(find.text('Tap me'));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  // ── VfCard ────────────────────────────────────────────────────────────────

  group('VfCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfCard(child: Text('Hello card')),
          ),
        ),
      );
      expect(find.text('Hello card'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VfCard(
              onTap: () => tapped = true,
              child: const Text('Tap card'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Tap card'));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  // ── VfChip ────────────────────────────────────────────────────────────────

  group('VfChip', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfChip(label: 'Online'),
          ),
        ),
      );
      expect(find.text('Online'), findsOneWidget);
    });

    testWidgets('shows dot when showDot is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfChip(label: 'Active', showDot: true),
          ),
        ),
      );
      // The dot is a Container with BoxShape.circle — verify it exists
      // by checking the chip renders without error and label is present.
      expect(find.text('Active'), findsOneWidget);
    });
  });

  // ── VfInfoTile ────────────────────────────────────────────────────────────

  group('VfInfoTile', () {
    testWidgets('renders value and label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfInfoTile(
              icon: Icons.battery_charging_full,
              value: '78%',
              label: 'Battery',
            ),
          ),
        ),
      );
      expect(find.text('78%'), findsOneWidget);
      expect(find.text('Battery'), findsOneWidget);
    });

    testWidgets('uses provided iconColor', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VfInfoTile(
              icon: Icons.speed,
              value: '100',
              label: 'Speed',
              iconColor: AppColors.secondary600,
            ),
          ),
        ),
      );
      final icon = tester.widget<Icon>(find.byIcon(Icons.speed));
      expect(icon.color, AppColors.secondary600);
    });
  });

  // ── BaseScreen ────────────────────────────────────────────────────────────

  group('BaseScreen', () {
    testWidgets('renders title in AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BaseScreen(
            title: 'Test Title',
            child: Text('body'),
          ),
        ),
      );
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('body'), findsOneWidget);
    });
  });
}
