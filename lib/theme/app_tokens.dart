import 'package:flutter/material.dart';

/// Design tokens exported as const values for Flutter.
class AppTokens {
  const AppTokens._();

  // ── Spacing (dp) ──────────────────────────────────────────────────────────
  static const double spacing0 = 0.0;
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 24.0;
  static const double spacing6 = 32.0;
  static const double spacing7 = 40.0;
  static const double spacing8 = 48.0;
  static const double spacing9 = 64.0;

  /// Semantic alias — small spacing (8 dp). Matches [spacing2].
  static const double spacingSm = spacing2;

  /// Semantic alias — medium spacing (16 dp). Matches [spacing4].
  static const double spacingMd = spacing4;

  /// Semantic alias — large spacing (24 dp). Matches [spacing5].
  static const double spacingLg = spacing5;

  // ── Radius (dp) ───────────────────────────────────────────────────────────
  static const double radiusNone = 0.0;
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusPill = 9999.0; // full pill shape

  /// Semantic alias — small corner radius (4 dp). Matches [radiusSmall].
  static const double radiusSm = radiusSmall;

  /// Semantic alias — medium corner radius (8 dp). Matches [radiusMedium].
  static const double radiusMd = radiusMedium;

  // ── Elevation (dp) ────────────────────────────────────────────────────────
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation3 = 4.0;
  static const double elevation4 = 8.0;

  /// Semantic alias — small elevation (2 dp). Matches [elevation2].
  static const double elevationSm = elevation2;

  // ── Typography ────────────────────────────────────────────────────────────
  /// VNEGREEN brand font — Poppins (Bold, SemiBold, Medium, Regular).
  static const String fontFamily = 'Poppins';
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  static const double fontSizeXS = 12.0;
  static const double fontSizeSM = 14.0;
  static const double fontSizeMD = 16.0;
  static const double fontSizeLG = 20.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 32.0;
}
