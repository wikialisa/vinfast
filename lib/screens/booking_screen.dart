import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';
import 'charging_station_search_screen.dart';

/// Màn hình đặt trước trụ sạc.
/// Chọn ngày + khung giờ + tính tiền cọc giữ chỗ (15 phút).
class BookingScreen extends StatefulWidget {
  final ChargingStation? station;
  const BookingScreen({super.key, this.station});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late ChargingStation _station;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  int _selectedSlot = 0;
  bool _isBooking = false;
  bool _booked = false;

  static const _depositVnd = 50000.0; // Tiền cọc 50k
  static const List<String> _slots = [
    '07:00 – 07:15',
    '07:15 – 07:30',
    '08:00 – 08:15',
    '08:30 – 08:45',
    '09:00 – 09:15',
    '10:00 – 10:15',
    '14:00 – 14:15',
    '15:30 – 15:45',
  ];

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

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _confirm() async {
    setState(() => _isBooking = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isBooking = false;
      _booked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Đặt trước trạm sạc'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
      ),
      body: _booked ? _buildSuccess() : _buildForm(),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_available,
                size: 80, color: AppColors.primary),
            const SizedBox(height: AppTokens.spacingMd),
            const Text('Đặt chỗ thành công!',
                style: AppTypography.h2, textAlign: TextAlign.center),
            const SizedBox(height: AppTokens.spacingSm),
            Text(
              '${_station.name}\n${_slots[_selectedSlot]}\n${_formatDate(_selectedDate)}',
              textAlign: TextAlign.center,
              style:
                  AppTypography.body.copyWith(color: AppColors.onSurface),
            ),
            const SizedBox(height: AppTokens.spacingMd),
            VfCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tiền cọc giữ chỗ', style: AppTypography.body),
                  Text(
                    _fmtVnd(_depositVnd),
                    style: AppTypography.h4
                        .copyWith(color: AppColors.primary700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
            SizedBox(
              width: double.infinity,
              child: VfButton(
                label: 'Về trang chủ',
                icon: Icons.home,
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Station info
          VfCard(
            color: AppColors.primary700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_station.name,
                    style:
                        AppTypography.h3.copyWith(color: AppColors.onPrimary)),
                const SizedBox(height: AppTokens.spacing1),
                Text(_station.address,
                    style: AppTypography.caption
                        .copyWith(color: AppColors.primary100)),
                const SizedBox(height: AppTokens.spacingMd),
                Row(
                  children: [
                    _Badge(icon: Icons.bolt, label: '${_station.powerKw.toInt()} kW'),
                    const SizedBox(width: AppTokens.spacingMd),
                    _Badge(icon: Icons.cable, label: _station.connectorType),
                    const SizedBox(width: AppTokens.spacingMd),
                    _Badge(
                        icon: Icons.electrical_services,
                        label: '${_station.availablePorts} trống'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          // Chọn ngày
          const Text('Chọn ngày', style: AppTypography.h4),
          const SizedBox(height: AppTokens.spacingMd),
          InkWell(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.all(AppTokens.spacingMd),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                color: AppColors.surface,
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: AppTokens.spacingMd),
                  Text(_formatDate(_selectedDate),
                      style: AppTypography.body
                          .copyWith(fontWeight: AppTokens.fontWeightMedium)),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: AppColors.onSurface),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          // Chọn khung giờ
          const Text('Khung giờ giữ chỗ (15 phút)', style: AppTypography.h4),
          const SizedBox(height: AppTokens.spacingMd),
          Wrap(
            spacing: AppTokens.spacingMd,
            runSpacing: AppTokens.spacingMd,
            children: List.generate(_slots.length, (i) {
              final selected = _selectedSlot == i;
              return ChoiceChip(
                label: Text(_slots[i]),
                selected: selected,
                onSelected: (_) => setState(() => _selectedSlot = i),
                selectedColor: AppColors.primary100,
                labelStyle: TextStyle(
                  color: selected ? AppColors.primary700 : AppColors.onSurface,
                  fontWeight: selected
                      ? AppTokens.fontWeightSemiBold
                      : AppTokens.fontWeightRegular,
                ),
              );
            }),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          // Tổng cộng
          VfCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tiền cọc giữ chỗ (15 phút)',
                        style: AppTypography.body),
                    Text(_fmtVnd(_depositVnd),
                        style: AppTypography.body.copyWith(
                            fontWeight: AppTokens.fontWeightSemiBold)),
                  ],
                ),
                const SizedBox(height: AppTokens.spacing2),
                Text(
                  '* Hoàn tiền nếu huỷ trước 5 phút',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.onSurface),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),

          VfButton(
            label: _isBooking ? 'Đang xử lý…' : 'Xác nhận đặt chỗ',
            icon: Icons.event_available,
            isLoading: _isBooking,
            onPressed: _isBooking ? null : _confirm,
          ),
        ],
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

String _fmtVnd(double v) =>
    '${v.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}đ';

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});

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
