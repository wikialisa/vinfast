import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/map_screen.dart';

void main() {
  testWidgets('MapScreen renders map placeholder and FAB',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MapScreen()),
    );
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('Map view placeholder'), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);
  });
}
