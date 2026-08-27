import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '/core/theme/theme.dart';
import '/core/router/router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/home'))      return 0;
    if (location.startsWith('/search'))    return 1;
    if (location.startsWith('/quick-buy')) return 2;
    if (location.startsWith('/orders'))    return 3;
    if (location.startsWith('/profile'))   return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _locationToIndex(location);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: child,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ZColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  _NavItem(
                    icon: Iconsax.home,
                    activeIcon: Iconsax.home_15,
                    label: 'خانه',
                    isActive: currentIndex == 0,
                    onTap: () => context.go(Routes.home),
                  ),
                  _NavItem(
                    icon: Iconsax.search_normal,
                    activeIcon: Iconsax.search_normal_1,
                    label: 'جستجو',
                    isActive: currentIndex == 1,
                    onTap: () => context.go(Routes.search),
                  ),
                  _NavItem(
                    icon: Iconsax.flash,
                    activeIcon: Iconsax.flash_1,
                    label: 'خرید سریع',
                    isActive: currentIndex == 2,
                    onTap: () => context.go(Routes.quickBuy),
                    isHighlighted: true,
                  ),
                  _NavItem(
                    icon: Iconsax.receipt,
                    activeIcon: Iconsax.receipt_1,
                    label: 'سفارش‌ها',
                    isActive: currentIndex == 3,
                    onTap: () => context.go(Routes.orders),
                  ),
                  _NavItem(
                    icon: Iconsax.user,
                    activeIcon: Iconsax.user_tick,
                    label: 'پروفایل',
                    isActive: currentIndex == 4,
                    onTap: () => context.go(Routes.profile),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? ZColors.primary : ZColors.gray500;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isHighlighted)
              Container(
                width: 44,
                height: 36,
                decoration: BoxDecoration(
                  color: isActive ? ZColors.primary : ZColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isActive ? activeIcon : icon,
                  color: isActive ? ZColors.white : ZColors.gray500,
                  size: 20,
                ),
              )
            else
              Icon(
                isActive ? activeIcon : icon,
                color: color,
                size: 24,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
