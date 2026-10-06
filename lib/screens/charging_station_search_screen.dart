import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';
import '../vinfast_core/widgets/common.dart';

/// Data model for a charging station listing.
class ChargingStation {
  final String id;
  final String name;
  final String address;
  final double distanceKm;
  final int availablePorts;
  final int totalPorts;
  final double powerKw;
  final String connectorType;
  final double pricePerKwh;
  final double rating;

  const ChargingStation({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.availablePorts,
    required this.totalPorts,
    required this.powerKw,
    required this.connectorType,
    required this.pricePerKwh,
    required this.rating,
  });

  bool get hasAvailablePort => availablePorts > 0;
}

/// Charging‑station search & filter screen.
/// Matches Roadmap Screen08 (List + Search + Filter Chips) and
/// VNEGREEN UI Kit Feature 4 (Smart Search & Filters).
class ChargingStationSearchScreen extends StatefulWidget {
  const ChargingStationSearchScreen({super.key});

  @override
  State<ChargingStationSearchScreen> createState() =>
      _ChargingStationSearchScreenState();
}

class _ChargingStationSearchScreenState
    extends State<ChargingStationSearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _selectedConnector;
  double? _minPower;

  static const List<String> _connectors = [
    'All',
    'CCS1',
    'CCS2',
    'Type 2',
    'Tesla',
    'CHAdeMO',
  ];

  static const List<ChargingStation> _allStations = [
    ChargingStation(
      id: 'vn001',
      name: 'VNEGREEN Hub – Hà Nội',
      address: '123 Trần Duy Hưng, Cầu Giấy, HN',
      distanceKm: 1.2,
      availablePorts: 4,
      totalPorts: 8,
      powerKw: 150,
      connectorType: 'CCS2',
      pricePerKwh: 3500,
      rating: 4.8,
    ),
    ChargingStation(
      id: 'vn002',
      name: 'VNEGREEN – Vincom Mega Mall',
      address: '72A Nguyễn Trãi, Thanh Xuân, HN',
      distanceKm: 2.5,
      availablePorts: 2,
      totalPorts: 6,
      powerKw: 50,
      connectorType: 'Type 2',
      pricePerKwh: 3200,
      rating: 4.5,
    ),
    ChargingStation(
      id: 'vn003',
      name: 'VNEGREEN – Times City',
      address: '458 Minh Khai, Hai Bà Trưng, HN',
      distanceKm: 3.1,
      availablePorts: 0,
      totalPorts: 4,
      powerKw: 22,
      connectorType: 'Type 2',
      pricePerKwh: 2900,
      rating: 4.2,
    ),
    ChargingStation(
      id: 'vn004',
      name: 'VNEGREEN Fast – Royal City',
      address: '72 Nguyễn Trãi, Thanh Xuân, HN',
      distanceKm: 2.6,
      availablePorts: 3,
      totalPorts: 4,
      powerKw: 150,
      connectorType: 'CCS2',
      pricePerKwh: 3800,
      rating: 4.9,
    ),
    ChargingStation(
      id: 'vn005',
      name: 'Tesla Supercharger – Lotte Center',
      address: '54 Liễu Giai, Ba Đình, HN',
      distanceKm: 4.0,
      availablePorts: 6,
      totalPorts: 6,
      powerKw: 250,
      connectorType: 'Tesla',
      pricePerKwh: 4200,
      rating: 4.7,
    ),
  ];

  List<ChargingStation> get _filtered {
    return _allStations.where((s) {
      final matchQuery = _query.isEmpty ||
          s.name.toLowerCase().contains(_query.toLowerCase()) ||
          s.address.toLowerCase().contains(_query.toLowerCase());
      final matchConnector = _selectedConnector == null ||
          _selectedConnector == 'All' ||
          s.connectorType == _selectedConnector;
      final matchPower = _minPower == null || s.powerKw >= _minPower!;
      return matchQuery && matchConnector && matchPower;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stations = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Find Charging Station'),
        backgroundColor: AppColors.primary600,
        foregroundColor: AppColors.onPrimary,
        elevation: AppTokens.elevationSm,
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            tooltip: 'Map view',
            onPressed: () => Navigator.pushNamed(context, '/map'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search bar ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.spacingLg,
              AppTokens.spacingMd,
              AppTokens.spacingLg,
              0,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search by name or address…',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primary600),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppTokens.spacingMd,
                ),
              ),
            ),
          ),

          // ── Connector filter chips ──────────────────────────────────────
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.spacingLg,
                vertical: AppTokens.spacing2,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _connectors.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppTokens.spacing2),
              itemBuilder: (context, i) {
                final c = _connectors[i];
                final selected = (_selectedConnector ?? 'All') == c;
                return FilterChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedConnector = c),
                  selectedColor: AppColors.primary100,
                  checkmarkColor: AppColors.primary700,
                  labelStyle: AppTypography.caption.copyWith(
                    color:
                        selected ? AppColors.primary700 : AppColors.onSurface,
                    fontWeight: selected
                        ? AppTokens.fontWeightSemiBold
                        : AppTokens.fontWeightRegular,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.primary600 : AppColors.divider,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                  ),
                );
              },
            ),
          ),

          // ── Power filter ────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
            child: Row(
              children: [
                const Text('Min power:', style: AppTypography.caption),
                const SizedBox(width: AppTokens.spacing2),
                for (final kw in [null, 22.0, 50.0, 150.0]) ...[
                  GestureDetector(
                    onTap: () => setState(() => _minPower = kw),
                    child: Container(
                      margin: const EdgeInsets.only(right: AppTokens.spacing2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.spacingMd,
                        vertical: AppTokens.spacing1,
                      ),
                      decoration: BoxDecoration(
                        color: _minPower == kw
                            ? AppColors.primary600
                            : AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppTokens.radiusPill),
                        border: Border.all(
                          color: _minPower == kw
                              ? AppColors.primary600
                              : AppColors.divider,
                        ),
                      ),
                      child: Text(
                        kw == null ? 'Any' : '≥${kw.toInt()} kW',
                        style: AppTypography.caption.copyWith(
                          color: _minPower == kw
                              ? AppColors.onPrimary
                              : AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Results count ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.spacingLg,
              vertical: AppTokens.spacing2,
            ),
            child: Row(
              children: [
                Text(
                  '${stations.length} station${stations.length == 1 ? '' : 's'} found',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),

          // ── Station list ────────────────────────────────────────────────
          Expanded(
            child: stations.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.ev_station_outlined,
                            size: 64, color: AppColors.divider),
                        SizedBox(height: AppTokens.spacingMd),
                        Text('No stations found', style: AppTypography.h4),
                        SizedBox(height: AppTokens.spacing2),
                        Text('Try adjusting your filters',
                            style: AppTypography.caption),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.spacingLg,
                      vertical: AppTokens.spacing2,
                    ),
                    itemCount: stations.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppTokens.spacingSm),
                    itemBuilder: (context, i) =>
                        _StationTile(station: stations[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _StationTile extends StatelessWidget {
  final ChargingStation station;
  const _StationTile({required this.station});

  @override
  Widget build(BuildContext context) {
    return VfCard(
      onTap: () =>
          Navigator.pushNamed(context, '/charging-session', arguments: station),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: station.hasAvailablePort
                  ? AppColors.primary100
                  : AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.ev_station,
              color: station.hasAvailablePort
                  ? AppColors.primary700
                  : AppColors.onSurface,
            ),
          ),
          const SizedBox(width: AppTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(station.name,
                          style: AppTypography.h4,
                          overflow: TextOverflow.ellipsis),
                    ),
                    VfChip(
                      label: station.hasAvailablePort
                          ? '${station.availablePorts} free'
                          : 'Full',
                      color: station.hasAvailablePort
                          ? AppColors.primary100
                          : AppColors.divider,
                      showDot: station.hasAvailablePort,
                    ),
                  ],
                ),
                const SizedBox(height: AppTokens.spacing1),
                Text(station.address,
                    style: AppTypography.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppTokens.spacing2),
                Row(
                  children: [
                    _MetaBadge(
                        icon: Icons.bolt,
                        label: '${station.powerKw.toInt()} kW'),
                    const SizedBox(width: AppTokens.spacing2),
                    _MetaBadge(
                        icon: Icons.cable_outlined,
                        label: station.connectorType),
                    const SizedBox(width: AppTokens.spacing2),
                    _MetaBadge(
                        icon: Icons.star_rounded,
                        label: station.rating.toStringAsFixed(1),
                        iconColor: AppColors.warning),
                    const Spacer(),
                    Text(
                      '${station.distanceKm.toStringAsFixed(1)} km',
                      style: AppTypography.caption
                          .copyWith(color: AppColors.primary600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const _MetaBadge({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? AppColors.onSurface),
        const SizedBox(width: 2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
