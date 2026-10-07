import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vinfast/screens/otp_screen.dart';

void main() {
  Widget _wrap({String? contact}) => MaterialApp(
        routes: {
          '/home': (_) => const Scaffold(body: Text('Home')),
        },
        home: OtpScreen(maskedContact: contact ?? '+84 *** *** 789'),
      );

  Future<void> pumpOtp(WidgetTester tester, {String? contact}) async {
    await tester.pumpWidget(_wrap(contact: contact));
  }

  group('OtpScreen – render', () {
    testWidgets('shows AppBar title "Verify OTP"', (tester) async {
      await pumpOtp(tester);
      expect(find.text('Verify OTP'), findsOneWidget);
    });

    testWidgets('shows header instruction text', (tester) async {
      await pumpOtp(tester);
      expect(find.text('Enter Verification Code'), findsOneWidget);
    });

    testWidgets('shows masked contact number from prop', (tester) async {
      await pumpOtp(tester, contact: '+84 *** *** 123');
      expect(find.textContaining('+84 *** *** 123'), findsOneWidget);
    });

    testWidgets('renders 6 digit input boxes', (tester) async {
      await pumpOtp(tester);
      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('Verify button is present', (tester) async {
      await pumpOtp(tester);
      expect(find.text('Verify'), findsOneWidget);
    });

    testWidgets('resend countdown text is shown initially', (tester) async {
      await tester.pumpWidget(_wrap());
      expect(find.textContaining('Resend code in'), findsOneWidget);
    });
  });

  group('OtpScreen – digit interaction', () {
    testWidgets('entering a digit into first box updates state', (tester) async {
      await pumpOtp(tester);
      await tester.enterText(find.byType(TextField).first, '1');
      await tester.pump();
      final firstField =
          tester.widget<TextField>(find.byType(TextField).first);
      expect(firstField.controller!.text, '1');
    });

    testWidgets('Verify button disabled when fewer than 6 digits entered',
        (tester) async {
      await pumpOtp(tester);
      final fields = find.byType(TextField);
      for (int i = 0; i < 3; i++) {
        await tester.enterText(fields.at(i), '$i');
      }
      await tester.pump();
      final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(btn.onPressed, isNull);
    });

    testWidgets('Verify button enabled when all 6 digits entered',
        (tester) async {
      await pumpOtp(tester);
      final fields = find.byType(TextField);
      for (int i = 0; i < 6; i++) {
        await tester.enterText(fields.at(i), '${i + 1}');
      }
      await tester.pump();
      final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(btn.onPressed, isNotNull);
    });
  });

  group('OtpScreen – verify flow', () {
    testWidgets('tapping Verify shows loading indicator', (tester) async {
      await pumpOtp(tester);
      final fields = find.byType(TextField);
      for (int i = 0; i < 6; i++) {
        await tester.enterText(fields.at(i), '${i + 1}');
      }
      await tester.pump();
      await tester.tap(find.text('Verify'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('after verify completes navigates to /home', (tester) async {
      await pumpOtp(tester);
      final fields = find.byType(TextField);
      for (int i = 0; i < 6; i++) {
        await tester.enterText(fields.at(i), '${i + 1}');
      }
      await tester.pump();
      await tester.tap(find.text('Verify'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('OtpScreen – resend', () {
    testWidgets('resend button appears after countdown expires', (tester) async {
      await tester.pumpWidget(_wrap());
      // Advance 31 seconds to expire the 30-second countdown
      await tester.pump(const Duration(seconds: 31));
      await tester.pump();
      expect(find.text('Resend code'), findsOneWidget);
    });
  });
}
