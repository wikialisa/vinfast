import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

// ── Dữ liệu giả (demo) ───────────────────────────────────────────────────────

class _ChargingHistory {
  final String station;
  final String date;
  final double kwh;
  final double cost;
  const _ChargingHistory(
      {required this.station,
      required this.date,
      required this.kwh,
      required this.cost});
}

const _history = [
  _ChargingHistory(
      station: 'VNEGREEN Hub – Landmark 81',
      date: '12/07/2025',
      kwh: 42.5,
      cost: 148750),
  _ChargingHistory(
      station: 'VNEGREEN Hub – Aeon Mall',
      date: '08/07/2025',
      kwh: 38.0,
      cost: 133000),
  _ChargingHistory(
      station: 'VNEGREEN Express – Q7',
      date: '01/07/2025',
      kwh: 55.2,
      cost: 193200),
];

/// Màn hình EV Garage & Ví sạc VNEGREEN.
class EvGarageScreen extends StatefulWidget {
  const EvGarageScreen({super.key});

  @override
  State<EvGarageScreen> createState() => _EvGarageScreenState();
}

class _EvGarageScreenState extends State<EvGarageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final double _soc = 78.0; // State of Charge %
  double _walletBalance = 850000.0; // VND

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _topUp(double amount) {
    setState(() => _walletBalance += amount);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nạp ${_fmtVnd(amount)} thành công!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Garage & Ví sạc'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: AppColors.onPrimary,
          labelColor: AppColors.onPrimary,
          unselectedLabelColor: AppColors.primary100,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car), text: 'Xe điện'),
            Tab(icon: Icon(Icons.account_balance_wallet), text: 'Ví sạc'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _GarageTab(soc: _soc),
          _WalletTab(
            balance: _walletBalance,
            history: _history,
            onTopUp: _topUp,
          ),
        ],
      ),
    );
  }
}

// ── Tab Xe điện ───────────────────────────────────────────────────────────────

class _GarageTab extends StatelessWidget {
  final double soc;
  const _GarageTab({required this.soc});

  @override
  Widget build(BuildContext context) {
    final rangeKm = (soc / 100 * 450).toStringAsFixed(0);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Vehicle hero
          VfCard(
            color: AppColors.primary700,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car,
                        size: 72, color: AppColors.onPrimary),
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
                          const SizedBox(height: AppTokens.spacing2),
                          const VfChip(label: 'Đang khoá'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTokens.spacingMd),
                // SoC bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pin xe',
                            style: AppTypography.caption
                                .copyWith(color: AppColors.primary100)),
                        Text('${soc.toStringAsFixed(0)}%',
                            style: AppTypography.h3
                                .copyWith(color: AppColors.onPrimary)),
                      ],
                    ),
                    const SizedBox(height: AppTokens.spacing2),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppTokens.radiusPill),
                      child: LinearProgressIndicator(
                        value: soc / 100,
                        minHeight: 12,
                        backgroundColor: AppColors.primary100.withValues(alpha: 0.3),
                        color: soc < 20
                            ? AppColors.error
                            : soc < 50
                                ? AppColors.secondary
                                : AppColors.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Metrics grid
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppTokens.spacingMd,
            mainAxisSpacing: AppTokens.spacingMd,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              VfInfoTile(
                icon: Icons.battery_charging_full,
                value: '${soc.toStringAsFixed(0)}%',
                label: 'Pin hiện tại',
                iconColor: AppColors.primary,
              ),
              VfInfoTile(
                icon: Icons.speed,
                value: '$rangeKm km',
                label: 'Phạm vi còn lại',
              ),
              const VfInfoTile(
                icon: Icons.electric_bolt,
                value: '87.7 kWh',
                label: 'Dung lượng pin',
              ),
              const VfInfoTile(
                icon: Icons.route,
                value: '12.430',
                label: 'Tổng km',
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingLg),

          VfButton(
            label: 'Tìm trạm sạc',
            icon: Icons.ev_station,
            onPressed: () => Navigator.pushNamed(context, '/stations'),
          ),
        ],
      ),
    );
  }
}

// ── Tab Ví sạc ────────────────────────────────────────────────────────────────

class _WalletTab extends StatelessWidget {
  final double balance;
  final List<_ChargingHistory> history;
  final ValueChanged<double> onTopUp;

  const _WalletTab(
      {required this.balance,
      required this.history,
      required this.onTopUp});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Balance card
          VfCard(
            color: AppColors.primary700,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_balance_wallet,
                        color: AppColors.onPrimary, size: 32),
                    const SizedBox(width: AppTokens.spacingMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ví VNEGREEN',
                            style: AppTypography.caption
                                .copyWith(color: AppColors.primary100)),
                        Text(
                          _fmtVnd(balance),
                          style: AppTypography.h2
                              .copyWith(color: AppColors.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTokens.spacingMd),
                Row(
                  children: [
                    Expanded(
                      child: VfButton.outlined(
                        label: '+100.000đ',
                        onPressed: () => onTopUp(100000),
                      ),
                    ),
                    const SizedBox(width: AppTokens.spacingMd),
                    Expanded(
                      child: VfButton.outlined(
                        label: '+200.000đ',
                        onPressed: () => onTopUp(200000),
                      ),
                    ),
                    const SizedBox(width: AppTokens.spacingMd),
                    Expanded(
                      child: VfButton.outlined(
                        label: '+500.000đ',
                        onPressed: () => onTopUp(500000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          const Text('Lịch sử sạc gần nhất', style: AppTypography.h4),
          const SizedBox(height: AppTokens.spacingMd),
          ...history.map((h) => Padding(
                padding:
                    const EdgeInsets.only(bottom: AppTokens.spacingMd),
                child: VfCard(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary100,
                          borderRadius:
                              BorderRadius.circular(AppTokens.radiusMd),
                        ),
                        child: const Icon(Icons.bolt,
                            color: AppColors.primary700, size: 22),
                      ),
                      const SizedBox(width: AppTokens.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(h.station,
                                style: AppTypography.body.copyWith(
                                    fontWeight: AppTokens.fontWeightMedium),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text('${h.date} · ${h.kwh.toStringAsFixed(1)} kWh',
                                style: AppTypography.caption
                                    .copyWith(color: AppColors.onSurface)),
                          ],
                        ),
                      ),
                      Text(_fmtVnd(h.cost),
                          style: AppTypography.body.copyWith(
                              fontWeight: AppTokens.fontWeightSemiBold,
                              color: AppColors.primary700)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _fmtVnd(double v) =>
    '${v.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}đ';
