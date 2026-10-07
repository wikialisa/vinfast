import 'dart:async';

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';
import 'charging_station_search_screen.dart';

/// Charging Session screen — covers the full pre‑auth → active‑session →
/// receipt flow described in VNEGREEN Payment Proposal §4.
///
/// State machine: [idle] → [preAuth] → [charging] → [stopped] → [receipt]
class ChargingSessionScreen extends StatefulWidget {
  final ChargingStation? station;
  const ChargingSessionScreen({super.key, this.station});

  @override
  State<ChargingSessionScreen> createState() => _ChargingSessionScreenState();
}

// Top-level payment constants shared between state and sub-views.
const double _kPreAuthAmount = 200000.0; // VND escrow hold
const double _kPricePerKwh = 3500.0; // VND per kWh

enum _SessionPhase { idle, preAuth, charging, stopped, receipt }

class _ChargingSessionScreenState extends State<ChargingSessionScreen> {
  _SessionPhase _phase = _SessionPhase.idle;

  // Simulated session data
  double _kwhDelivered = 0.0;
  double _estimatedCost = 0.0;
  String? _receiptId;
  Timer? _chargingTimer;

  late final ChargingStation _station;

  @override
  void initState() {
    super.initState();
    _station = widget.station ??
        const ChargingStation(
          id: 'demo',
          name: 'VNEGREEN Hub – Demo',
          address: '123 Demo Street',
          distanceKm: 0.5,
          availablePorts: 2,
          totalPorts: 4,
          powerKw: 150,
          connectorType: 'CCS2',
          pricePerKwh: 3500,
          rating: 4.9,
        );
  }

  @override
  void dispose() {
    _chargingTimer?.cancel();
    super.dispose();
  }

  // ── Phase transitions ─────────────────────────────────────────────────────

  Future<void> _startPreAuth() async {
    setState(() => _phase = _SessionPhase.preAuth);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _phase = _SessionPhase.charging);
    _startChargingTimer();
  }

  void _startChargingTimer() {
    _scheduleChargingTick();
  }

  void _scheduleChargingTick() {
    _chargingTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || _phase != _SessionPhase.charging) return;
      setState(() {
        _kwhDelivered += 0.5;
        _estimatedCost = _kwhDelivered * _kPricePerKwh;
      });
      _scheduleChargingTick();
    });
  }

  Future<void> _stopSession() async {
    _chargingTimer?.cancel();
    setState(() => _phase = _SessionPhase.stopped);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _receiptId = 'RCP-${DateTime.now().millisecondsSinceEpoch}';
      _phase = _SessionPhase.receipt;
    });
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Charging Session'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_phase) {
      case _SessionPhase.idle:
        return _IdleView(station: _station, onStart: _startPreAuth);
      case _SessionPhase.preAuth:
        return _LoadingView(
          message: 'Authorising payment…',
          sub: 'Holding ${_formatVnd(_kPreAuthAmount)} escrow',
        );
      case _SessionPhase.charging:
        return _ChargingView(
          station: _station,
          kwhDelivered: _kwhDelivered,
          estimatedCost: _estimatedCost,
          onStop: _stopSession,
        );
      case _SessionPhase.stopped:
        return const _LoadingView(
          message: 'Finalising payment…',
          sub: 'Capturing actual amount',
        );
      case _SessionPhase.receipt:
        return _ReceiptView(
          station: _station,
          kwhDelivered: _kwhDelivered,
          totalCost: _estimatedCost,
          receiptId: _receiptId!,
          onDone: () => Navigator.pushReplacementNamed(context, '/home'),
        );
    }
  }
}

// ── Sub‑views ──────────────────────────────────────────────────────────────

class _IdleView extends StatelessWidget {
  final ChargingStation station;
  final VoidCallback onStart;
  const _IdleView({required this.station, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VfCard(
          color: AppColors.primary700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(station.name,
                  style: AppTypography.h3.copyWith(color: AppColors.onPrimary)),
              const SizedBox(height: AppTokens.spacing1),
              Text(station.address,
                  style: AppTypography.caption
                      .copyWith(color: AppColors.primary100)),
              const SizedBox(height: AppTokens.spacingMd),
              Row(
                children: [
                  _MetaBadge(
                      icon: Icons.bolt, label: '${station.powerKw.toInt()} kW'),
                  const SizedBox(width: AppTokens.spacingMd),
                  _MetaBadge(
                      icon: Icons.cable_outlined, label: station.connectorType),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.spacingLg),
        VfCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Payment Pre‑Auth', style: AppTypography.h4),
              const SizedBox(height: AppTokens.spacing2),
              Text(
                'We will temporarily hold ${_formatVnd(_kPreAuthAmount)} on your payment method. '
                'After charging, only the actual amount will be captured.',
                style: AppTypography.body.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: AppTokens.spacingMd),
              Row(
                children: [
                  const Icon(Icons.credit_card,
                      color: AppColors.primary600, size: 20),
                  const SizedBox(width: AppTokens.spacing2),
                  Text('Visa •••• 4242',
                      style: AppTypography.body
                          .copyWith(fontWeight: AppTokens.fontWeightMedium)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Change'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        VfButton(
          label: 'Start Charging',
          icon: Icons.flash_on,
          onPressed: onStart,
        ),
      ],
    );
  }
}

class _ChargingView extends StatelessWidget {
  final ChargingStation station;
  final double kwhDelivered;
  final double estimatedCost;
  final VoidCallback onStop;

  const _ChargingView({
    required this.station,
    required this.kwhDelivered,
    required this.estimatedCost,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Animated charging indicator
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: (kwhDelivered / 60).clamp(0, 1),
                    strokeWidth: 10,
                    backgroundColor: AppColors.primary100,
                    color: AppColors.primary600,
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.bolt,
                        size: 36, color: AppColors.primary600),
                    Text(
                      '${kwhDelivered.toStringAsFixed(1)} kWh',
                      style: AppTypography.h2
                          .copyWith(color: AppColors.primary700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: AppTokens.spacingMd,
            mainAxisSpacing: AppTokens.spacingMd,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              VfInfoTile(
                icon: Icons.attach_money,
                value: _formatVnd(estimatedCost),
                label: 'Est. Cost',
                iconColor: AppColors.secondary,
              ),
              VfInfoTile(
                icon: Icons.bolt,
                value: '${station.powerKw.toInt()} kW',
                label: 'Power',
              ),
              VfInfoTile(
                icon: Icons.timer_outlined,
                value:
                    '${(kwhDelivered / (station.powerKw / 60)).toStringAsFixed(0)} min',
                label: 'Time',
              ),
              VfInfoTile(
                icon: Icons.battery_charging_full,
                value:
                    '${(kwhDelivered * 1.5).clamp(0, 100).toStringAsFixed(0)}%',
                label: 'Battery',
                iconColor: AppColors.primary600,
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingLg),
          VfButton(
            label: 'Stop Charging',
            icon: Icons.stop_circle_outlined,
            onPressed: onStop,
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String message;
  final String sub;
  const _LoadingView({required this.message, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary600),
          const SizedBox(height: AppTokens.spacingLg),
          Text(message, style: AppTypography.h3),
          const SizedBox(height: AppTokens.spacing2),
          Text(sub,
              style: AppTypography.body.copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

class _ReceiptView extends StatelessWidget {
  final ChargingStation station;
  final double kwhDelivered;
  final double totalCost;
  final String receiptId;
  final VoidCallback onDone;

  const _ReceiptView({
    required this.station,
    required this.kwhDelivered,
    required this.totalCost,
    required this.receiptId,
    required this.onDone,
  });

  // CO₂ tiết kiệm: 0.5 kg CO₂ mỗi kWh so với động cơ xăng
  double get _co2SavedKg => kwhDelivered * 0.5;

  // Điểm thưởng xanh: 10 điểm / kWh
  int get _greenPoints => (kwhDelivered * 10).toInt();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.check_circle, size: 72, color: AppColors.primary600),
          const SizedBox(height: AppTokens.spacingMd),
          const Text('Charging Complete!',
              textAlign: TextAlign.center, style: AppTypography.h2),
          const SizedBox(height: AppTokens.spacingLg),
          VfCard(
            child: Column(
              children: [
                _ReceiptRow(label: 'Station', value: station.name),
                const Divider(color: AppColors.divider),
                _ReceiptRow(
                    label: 'Energy Delivered',
                    value: '${kwhDelivered.toStringAsFixed(2)} kWh'),
                _ReceiptRow(
                    label: 'Unit Price',
                    value: '${_formatVnd(station.pricePerKwh)} / kWh'),
                const Divider(color: AppColors.divider),
                _ReceiptRow(
                    label: 'Total', value: _formatVnd(totalCost), bold: true),
                const _ReceiptRow(label: 'Payment', value: 'Visa •••• 4242'),
                _ReceiptRow(label: 'Receipt ID', value: receiptId),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),
          // ── CO₂ & Green Points ──────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: VfCard(
                  color: AppColors.primary100,
                  child: Column(
                    children: [
                      const Icon(Icons.eco,
                          color: AppColors.primary700, size: 28),
                      const SizedBox(height: AppTokens.spacing1),
                      Text(
                        '${_co2SavedKg.toStringAsFixed(1)} kg',
                        style: AppTypography.h3
                            .copyWith(color: AppColors.primary700),
                      ),
                      const Text('CO₂ tiết kiệm', style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              Expanded(
                child: VfCard(
                  color: AppColors.primary100,
                  child: Column(
                    children: [
                      const Icon(Icons.star,
                          color: AppColors.secondary, size: 28),
                      const SizedBox(height: AppTokens.spacing1),
                      Text(
                        '$_greenPoints pts',
                        style: AppTypography.h3
                            .copyWith(color: AppColors.primary700),
                      ),
                      const Text('Điểm thưởng xanh', style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingLg),
          Row(
            children: [
              Expanded(
                child: VfButton.outlined(
                  label: 'Share',
                  icon: Icons.share_outlined,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              Expanded(
                child: VfButton(
                  label: 'Done',
                  icon: Icons.home_outlined,
                  onPressed: onDone,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _ReceiptRow(
      {required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? AppTypography.h4.copyWith(color: AppColors.primary700)
        : AppTypography.body;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.spacing1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.caption),
          Flexible(
            child: Text(value,
                style: style,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primary100),
        const SizedBox(width: 4),
        Text(label,
            style: AppTypography.caption.copyWith(color: AppColors.primary100)),
      ],
    );
  }
}

String _formatVnd(double amount) {
  final int rounded = amount.round();
  final formatted = rounded.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
      );
  return '$formattedđ';
}
