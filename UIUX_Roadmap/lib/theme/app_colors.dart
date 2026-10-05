import 'package:flutter/material.dart';

/// Color palette adhering to the Digital‑Arithmetic Colour Law.
/// All colours satisfy: R + G + B ≡ 0 (mod 9).
class AppColors {
  const AppColors._();

  // ── Base tokens ──────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF336699);     // (51,102,153) → 306
  static const Color secondary = Color(0xFF669933);   // (102,153,51) → 306
  static const Color accent = Color(0xFFCC3333);      // (204,51,51)  → 306
  static const Color background = Color(0xFFD8D8D8);  // (216,216,216)→ 648
  static const Color surface = Color(0xFFFFFFFF);     // (255,255,255)→ 765
  static const Color onPrimary = Color(0xFFFFFFFF);   // (255,255,255)→ 765
  static const Color onBackground = Color(0xFF333333);// (51,51,51)   → 153

  // ── Extended tint/shade tokens ────────────────────────────────────────────
  /// Light tint of primary — used for card/surface backgrounds.
  /// (198, 216, 234) → sum = 648 ✅
  static const Color primary100 = Color(0xFFC6D8EA);

  /// Main interactive shade of primary — used for AppBar, buttons.
  /// Alias for [primary].
  static const Color primary600 = primary;

  /// Main interactive shade of secondary — used for FABs, secondary buttons.
  /// Alias for [secondary].
  static const Color secondary600 = secondary;
}
