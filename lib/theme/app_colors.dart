import 'package:flutter/material.dart';

/// VNEGREEN Color System — Digital‑Arithmetic Colour Law.
/// All colours satisfy: R + G + B ≡ 0 (mod 9).
///
/// VNEGREEN brand: technology‑green primary on a modern dark background.
class AppColors {
  const AppColors._();

  // ── Light Mode Base ──────────────────────────────────────────────────────
  /// Technology green — primary brand colour.
  /// (27, 153, 54) → 234 ✅
  static const Color primary = Color(0xFF1B9936);

  /// Deep green — used for emphasis and headings.
  /// (18, 108, 36) → 162 ✅
  static const Color primary700 = Color(0xFF126C24);

  /// Light tint of primary — card/chip backgrounds.
  /// (207, 237, 213) → 657 ✅  (9 × 73)
  static const Color primary100 = Color(0xFFCFEDD5);

  /// Secondary accent — amber/gold for energy / warning cues.
  /// (204, 153, 0) → 357 ✅  (9 × 39 + 6 — rounded to nearest) — wait:
  /// Let's use (198, 153, 9) → 360 ✅
  static const Color secondary = Color(0xFFC69909);

  /// Error / danger.
  /// (204, 51, 51) → 306 ✅
  static const Color error = Color(0xFFCC3333);

  /// Light‑mode background.
  /// (243, 244, 246) → 633 ✅  (9 × 70 + 3 — rounded to nearest multiple)
  /// Use (243, 243, 243) → 729 ✅
  static const Color background = Color(0xFFF3F3F3);

  /// Light‑mode surface (cards, sheets).
  static const Color surface = Color(0xFFFFFFFF); // 765 ✅

  /// Text on primary / on dark backgrounds.
  static const Color onPrimary = Color(0xFFFFFFFF); // 765 ✅

  /// Body text on light background.
  /// (51, 51, 51) → 153 ✅
  static const Color onBackground = Color(0xFF333333);

  /// Secondary text / muted labels.
  /// (102, 102, 102) → 306 ✅
  static const Color onSurface = Color(0xFF666666);

  // ── Aliases (keep API compatible with original tokens) ────────────────────
  static const Color primary600 = primary;
  static const Color secondary600 = secondary;

  // ── Dark Mode Tokens ──────────────────────────────────────────────────────
  /// Dark‑mode canvas — deep charcoal.
  /// (18, 18, 18) → 54 ✅
  static const Color darkBackground = Color(0xFF121212);

  /// Dark‑mode surface — slightly lighter than canvas.
  /// (30, 30, 30) → 90 ✅
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// Dark‑mode card surface.
  /// (39, 39, 39) → 117 ✅
  static const Color darkCard = Color(0xFF272727);

  /// Text on dark background — near‑white.
  /// (237, 237, 237) → 711 ✅
  static const Color darkOnBackground = Color(0xFFEDEDED);

  /// Muted text on dark surfaces.
  /// (153, 153, 153) → 459 ✅
  static const Color darkOnSurface = Color(0xFF999999);

  // ── Semantic Utility ──────────────────────────────────────────────────────
  /// Success state (alias of primary).
  static const Color success = primary;

  /// Warning state (alias of secondary).
  static const Color warning = secondary;

  /// Divider / border line.
  /// (216, 216, 216) → 648 ✅
  static const Color divider = Color(0xFFD8D8D8);
}
