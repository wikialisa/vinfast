import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

/// OTP verification screen — used after login / signup to verify phone number.
/// Matches Roadmap Screen06 (Signup flow) and Payment Proposal §7 Sprint 7‑8
/// (OTP via Twilio/Viettel).
class OtpScreen extends StatefulWidget {
  /// The masked phone/email to display in the subtitle.
  final String maskedContact;

  const OtpScreen({super.key, this.maskedContact = '+84 *** *** 789'});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _otpLength = 6;
  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  bool _isVerifying = false;
  int _resendSeconds = 30;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendSeconds = 30;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        _resendTimer?.cancel();
        return;
      }
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        _resendTimer?.cancel();
      }
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onDigitInput(int index, String value) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verify() async {
    if (_otp.length < _otpLength) return;
    setState(() => _isVerifying = true);
    // Simulate network call — replace with real auth service call.
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool allFilled = _otp.length == _otpLength;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacingLg,
            vertical: AppTokens.spacing9,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ────────────────────────────────────────────────
              const Icon(
                Icons.sms_outlined,
                size: 56,
                color: AppColors.primary600,
              ),
              const SizedBox(height: AppTokens.spacingMd),
              const Text(
                'Enter Verification Code',
                textAlign: TextAlign.center,
                style: AppTypography.h2,
              ),
              const SizedBox(height: AppTokens.spacing2),
              Text(
                'We sent a 6‑digit code to\n${widget.maskedContact}',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: AppTokens.spacing9),

              // ── OTP Digit Boxes ───────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_otpLength, (i) {
                  return SizedBox(
                    width: 48,
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: AppTypography.h3
                          .copyWith(color: AppColors.primary700),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: _controllers[i].text.isNotEmpty
                            ? AppColors.primary100
                            : AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppTokens.radiusMd),
                          borderSide: BorderSide(
                            color: _controllers[i].text.isNotEmpty
                                ? AppColors.primary600
                                : AppColors.divider,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppTokens.radiusMd),
                          borderSide: const BorderSide(
                            color: AppColors.primary600,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (v) => _onDigitInput(i, v),
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppTokens.spacingLg),

              // ── Verify button ─────────────────────────────────────────
              VfButton(
                label: 'Verify',
                icon: Icons.check_circle_outline,
                isLoading: _isVerifying,
                onPressed: allFilled ? _verify : null,
              ),
              const SizedBox(height: AppTokens.spacingMd),

              // ── Resend ────────────────────────────────────────────────
              Center(
                child: _resendSeconds > 0
                    ? Text(
                        'Resend code in $_resendSeconds s',
                        style: AppTypography.caption,
                      )
                    : TextButton(
                        onPressed: () {
                          setState(() => _resendSeconds = 30);
                          _startResendTimer();
                        },
                        child: Text(
                          'Resend code',
                          style: AppTypography.body
                              .copyWith(color: AppColors.primary600),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
