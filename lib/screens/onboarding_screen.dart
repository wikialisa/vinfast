import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../vinfast_core/widgets/common.dart';

/// Dữ liệu một trang onboarding.
class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  const _OnboardingPage(
      {required this.icon, required this.title, required this.subtitle});
}

const _pages = [
  _OnboardingPage(
    icon: Icons.ev_station,
    title: 'Sạc nhanh 350 kW',
    subtitle:
        'Tìm trạm sạc siêu tốc CCS2, Type 2, CHAdeMO gần bạn nhất – chỉ trong vài giây.',
  ),
  _OnboardingPage(
    icon: Icons.map_outlined,
    title: 'Bản đồ thông minh',
    subtitle:
        'Xem trạng thái trống/bận theo thời gian thực, lọc theo công suất và loại đầu cắm.',
  ),
  _OnboardingPage(
    icon: Icons.lock_open_outlined,
    title: 'Điều khiển xe từ xa',
    subtitle:
        'Mở/khoá cửa, bật điều hoà, kiểm tra áp suất lốp — mọi lúc, mọi nơi.',
  ),
];

/// Màn hình Onboarding 3 bước.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _page = 0;
  final PageController _ctrl = PageController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _ctrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skip() => Navigator.pushReplacementNamed(context, '/login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skip,
                child: const Text(
                  'Bỏ qua',
                  style: TextStyle(color: AppColors.onSurface),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _PageView(page: _pages[i]),
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppTokens.spacing1),
                  width: _page == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _page == i ? AppColors.primary : AppColors.primary100,
                    borderRadius:
                        BorderRadius.circular(AppTokens.radiusPill),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),

            // CTA Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.spacingLg,
              ),
              child: SizedBox(
                width: double.infinity,
                child: VfButton(
                  label: _page < _pages.length - 1 ? 'Tiếp theo' : 'Bắt đầu',
                  icon: _page < _pages.length - 1
                      ? Icons.arrow_forward
                      : Icons.check,
                  onPressed: _next,
                ),
              ),
            ),
            const SizedBox(height: AppTokens.spacingLg),
          ],
        ),
      ),
    );
  }
}

class _PageView extends StatelessWidget {
  final _OnboardingPage page;
  const _PageView({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(page.icon, size: 64, color: AppColors.primary700),
          ),
          const SizedBox(height: AppTokens.spacingLg),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppTokens.fontSizeXL,
              fontWeight: AppTokens.fontWeightBold,
              color: AppColors.onBackground,
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppTokens.fontSizeSM,
              color: AppColors.onSurface,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
