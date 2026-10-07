import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

// ── Trạng thái từng tính năng điều khiển ────────────────────────────────────

enum _LockState { locked, unlocked }

enum _AcState { off, on }

/// Màn hình điều khiển xe từ xa (Remote Car Control).
/// Tính năng: Lock/Unlock, AC 22°C, TPMS, Mở nắp cổng sạc.
class CarRemoteScreen extends StatefulWidget {
  const CarRemoteScreen({super.key});

  @override
  State<CarRemoteScreen> createState() => _CarRemoteScreenState();
}

class _CarRemoteScreenState extends State<CarRemoteScreen> {
  _LockState _lockState = _LockState.locked;
  _AcState _acState = _AcState.off;
  bool _chargingPortOpen = false;
  bool _isLockLoading = false;
  bool _isAcLoading = false;
  bool _isPortLoading = false;

  // Giả lập độ trễ lệnh 1.5s
  Future<void> _toggleLock() async {
    setState(() => _isLockLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      _lockState = _lockState == _LockState.locked
          ? _LockState.unlocked
          : _LockState.locked;
      _isLockLoading = false;
    });
    _showSnack(
      _lockState == _LockState.locked ? 'Đã khoá cửa' : 'Đã mở khoá cửa',
    );
  }

  Future<void> _toggleAc() async {
    setState(() => _isAcLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      _acState =
          _acState == _AcState.off ? _AcState.on : _AcState.off;
      _isAcLoading = false;
    });
    _showSnack(
      _acState == _AcState.on ? 'Điều hoà bật – 22°C' : 'Điều hoà tắt',
    );
  }

  Future<void> _togglePort() async {
    setState(() => _isPortLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      _chargingPortOpen = !_chargingPortOpen;
      _isPortLoading = false;
    });
    _showSnack(_chargingPortOpen ? 'Nắp sạc đã mở' : 'Nắp sạc đã đóng');
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Điều khiển xe từ xa'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Vehicle card ───────────────────────────────────────────────
            VfCard(
              color: AppColors.primary700,
              child: Row(
                children: [
                  const Icon(Icons.directions_car,
                      size: 64, color: AppColors.onPrimary),
                  const SizedBox(width: AppTokens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VinFast VF 8',
                            style: AppTypography.h3
                                .copyWith(color: AppColors.onPrimary)),
                        Text('51A – 123.45',
                            style: AppTypography.caption
                                .copyWith(color: AppColors.primary100)),
                      ],
                    ),
                  ),
                  VfChip(
                    label: _lockState == _LockState.locked ? 'Khoá' : 'Mở',
                    color: _lockState == _LockState.locked
                        ? AppColors.primary100
                        : AppColors.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),

            // ── Điều khiển chính ────────────────────────────────────────────
            const Text('Điều khiển', style: AppTypography.h4),
            const SizedBox(height: AppTokens.spacingMd),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: AppTokens.spacingMd,
              mainAxisSpacing: AppTokens.spacingMd,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: [
                // Lock/Unlock
                _ControlTile(
                  icon: _lockState == _LockState.locked
                      ? Icons.lock
                      : Icons.lock_open,
                  label: _lockState == _LockState.locked
                      ? 'Mở khoá'
                      : 'Khoá cửa',
                  isActive: _lockState == _LockState.unlocked,
                  isLoading: _isLockLoading,
                  onTap: _toggleLock,
                ),
                // AC
                _ControlTile(
                  icon: Icons.ac_unit,
                  label: _acState == _AcState.off ? 'Bật AC' : 'Tắt AC',
                  subtitle: _acState == _AcState.on ? '22°C' : null,
                  isActive: _acState == _AcState.on,
                  isLoading: _isAcLoading,
                  onTap: _toggleAc,
                ),
                // Charging port
                _ControlTile(
                  icon: Icons.power,
                  label: _chargingPortOpen ? 'Đóng nắp sạc' : 'Mở nắp sạc',
                  isActive: _chargingPortOpen,
                  isLoading: _isPortLoading,
                  onTap: _togglePort,
                ),
                // TPMS (read-only)
                const _ControlTile(
                  icon: Icons.tire_repair,
                  label: 'Áp suất lốp',
                  subtitle: 'Bình thường',
                  isActive: false,
                  isLoading: false,
                  onTap: null,
                ),
              ],
            ),
            const SizedBox(height: AppTokens.spacingLg),

            // ── TPMS detail ─────────────────────────────────────────────────
            const Text('Áp suất lốp (TPMS)', style: AppTypography.h4),
            const SizedBox(height: AppTokens.spacingMd),
            const VfCard(
              child: Column(
                children: [
                  _TyreRow(position: 'Trước trái', psi: '35.2 psi', ok: true),
                  Divider(color: AppColors.divider),
                  _TyreRow(position: 'Trước phải', psi: '35.0 psi', ok: true),
                  Divider(color: AppColors.divider),
                  _TyreRow(position: 'Sau trái', psi: '33.8 psi', ok: true),
                  Divider(color: AppColors.divider),
                  _TyreRow(position: 'Sau phải', psi: '34.1 psi', ok: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _ControlTile ─────────────────────────────────────────────────────────────

class _ControlTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool isActive;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ControlTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.isActive,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return VfCard(
      color: isActive ? AppColors.primary100 : AppColors.surface,
      onTap: isLoading ? null : onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              : Icon(
                  icon,
                  size: 32,
                  color: isActive ? AppColors.primary700 : AppColors.onSurface,
                ),
          const SizedBox(height: AppTokens.spacing2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              fontWeight: AppTokens.fontWeightMedium,
              color: isActive ? AppColors.primary700 : AppColors.onBackground,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppTokens.spacing1),
            Text(subtitle!, style: AppTypography.caption),
          ],
        ],
      ),
    );
  }
}

// ── _TyreRow ──────────────────────────────────────────────────────────────────

class _TyreRow extends StatelessWidget {
  final String position;
  final String psi;
  final bool ok;

  const _TyreRow(
      {required this.position, required this.psi, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.spacing2),
      child: Row(
        children: [
          Text(position,
              style: AppTypography.body
                  .copyWith(fontWeight: AppTokens.fontWeightMedium)),
          const Spacer(),
          Text(psi, style: AppTypography.body),
          const SizedBox(width: AppTokens.spacing2),
          Icon(
            ok ? Icons.check_circle : Icons.warning,
            size: 18,
            color: ok ? AppColors.primary : AppColors.error,
          ),
        ],
      ),
    );
  }
}
