import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/UIUX_Roadmap/lib/screens/remote_control_screen.dart';

void main() {
  testWidgets('RemoteControlScreen shows all four control buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RemoteControlScreen()),
    );
    expect(find.text('Remote Control'), findsOneWidget);
    expect(find.text('Lock/Unlock'), findsOneWidget);
    expect(find.text('Lights'), findsOneWidget);
    expect(find.text('Climate'), findsOneWidget);
    expect(find.text('Horn'), findsOneWidget);
  });
}
