import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/battery_detail_screen.dart';

void main() {
  testWidgets('BatteryDetailScreen shows battery level',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: BatteryDetailScreen()),
    );
    expect(find.text('Battery Level'), findsOneWidget);
    expect(find.textContaining('78%'), findsOneWidget);
  });
}
