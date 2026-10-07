// lib/vinfast_core/widgets/common.dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_tokens.dart';
import '../../theme/app_typography.dart';

/// A simple scaffold wrapper used by all prototype screens.
/// It applies the design‑system colours and spacing automatically.
class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  const BaseScreen({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: child,
      ),
    );
  }
}

// ─── VfButton ─────────────────────────────────────────────────────────────────

/// Design‑system primary button.
///
/// Usage:
/// ```dart
/// VfButton(label: 'Sign In', onPressed: () {})
/// VfButton.secondary(label: 'Cancel', onPressed: () {})
/// VfButton(label: 'Loading', isLoading: true, onPressed: null)
/// ```
class VfButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final _VfButtonVariant _variant;

  const VfButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _VfButtonVariant.primary;

  const VfButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _VfButtonVariant.secondary;

  const VfButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  }) : _variant = _VfButtonVariant.outlined;

  @override
  Widget build(BuildContext context) {
    final Color bg = _variant == _VfButtonVariant.secondary
        ? AppColors.secondary600
        : AppColors.primary600;

    final Widget labelWidget = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.onPrimary,
            ),
          )
        : Text(label,
            style: AppTypography.body.copyWith(
                color: AppColors.onPrimary,
                fontWeight: AppTokens.fontWeightMedium));

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusSm),
      side: _variant == _VfButtonVariant.outlined
          ? const BorderSide(color: AppColors.primary600)
          : BorderSide.none,
    );

    if (_variant == _VfButtonVariant.outlined) {
      return OutlinedButton.icon(
        icon: icon != null
            ? Icon(icon, size: 18, color: AppColors.primary600)
            : const SizedBox.shrink(),
        label: Text(label,
            style: AppTypography.body.copyWith(
                color: AppColors.primary600,
                fontWeight: AppTokens.fontWeightMedium)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: AppTokens.spacingMd,
            horizontal: AppTokens.spacingLg,
          ),
          shape: shape,
        ),
        onPressed: isLoading ? null : onPressed,
      );
    }

    if (icon != null) {
      return ElevatedButton.icon(
        icon: isLoading ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: labelWidget,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            vertical: AppTokens.spacingMd,
            horizontal: AppTokens.spacingLg,
          ),
          shape: shape,
          elevation: AppTokens.elevation2,
        ),
        onPressed: isLoading ? null : onPressed,
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: AppColors.onPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: AppTokens.spacingMd,
          horizontal: AppTokens.spacingLg,
        ),
        shape: shape,
        elevation: AppTokens.elevation2,
      ),
      onPressed: isLoading ? null : onPressed,
      child: labelWidget,
    );
  }
}

enum _VfButtonVariant { primary, secondary, outlined }

// ─── VfCard ───────────────────────────────────────────────────────────────────

/// Design‑system card container with consistent radius and surface colour.
class VfCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const VfCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? AppColors.surface,
      elevation: AppTokens.elevation2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTokens.spacingMd),
          child: child,
        ),
      ),
    );
  }
}

// ─── VfChip ───────────────────────────────────────────────────────────────────

/// Design‑system status chip with optional dot indicator.
class VfChip extends StatelessWidget {
  final String label;
  final Color? color;
  final bool showDot;

  const VfChip({
    super.key,
    required this.label,
    this.color,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? AppColors.primary100;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.spacingMd,
        vertical: AppTokens.spacing1,
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondary600,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppTokens.spacing1),
          ],
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

// ─── VfInfoTile ───────────────────────────────────────────────────────────────

/// A labelled metric tile — shows an icon, a value, and a unit/label.
///
/// Used on Dashboard, Battery Detail, etc.
class VfInfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;

  const VfInfoTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return VfCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: iconColor ?? AppColors.primary600),
          const SizedBox(height: AppTokens.spacing2),
          Text(value,
              style: AppTypography.h3.copyWith(color: AppColors.primary700)),
          const SizedBox(height: AppTokens.spacing1),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}
