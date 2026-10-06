import 'package:flutter/material.dart';
import 'app_tokens.dart';
import 'app_colors.dart';

/// Typography styles derived from the design-system token set.
class AppTypography {
  const AppTypography._();

  static const TextStyle h1 = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeXXL,
    fontWeight: AppTokens.fontWeightBold,
    color: AppColors.onBackground,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeXL,
    fontWeight: AppTokens.fontWeightBold,
    color: AppColors.onBackground,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeLG,
    fontWeight: AppTokens.fontWeightBold,
    color: AppColors.onBackground,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeMD,
    fontWeight: AppTokens.fontWeightMedium,
    color: AppColors.onBackground,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeSM,
    fontWeight: AppTokens.fontWeightRegular,
    color: AppColors.onBackground,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: AppTokens.fontFamily,
    fontSize: AppTokens.fontSizeXS,
    fontWeight: AppTokens.fontWeightRegular,
    color: AppColors.onSurface,
  );
}
