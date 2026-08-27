import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/storage_service.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/category_products_page.dart';
import '../../features/products/presentation/pages/search_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/checkout_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/orders/presentation/pages/order_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/addresses/presentation/pages/addresses_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../shared/widgets/main_scaffold.dart';

// ── Route names ───────────────────────────────────────────────────────────────

class Routes {
  Routes._();

  static const splash         = '/';
  static const login          = '/login';
  static const otp            = '/otp';
  static const home           = '/home';
  static const search         = '/search';
  static const quickBuy       = '/quick-buy';
  static const categories     = '/categories';
  static const categoryDetail = '/categories/:id';
  static const productDetail  = '/products/:id';
  static const cart           = '/cart';
  static const checkout       = '/checkout';
  static const orders         = '/orders';
  static const orderDetail    = '/orders/:id';
  static const profile        = '/profile';
  static const addresses      = '/addresses';
  static const favorites      = '/favorites';
  static const notifications  = '/notifications';
  static const settings       = '/settings';
}

// ── Router provider ───────────────────────────────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  final storage = StorageService();

  return GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final isLoggedIn = storage.isLoggedIn;
      final isAuthRoute = state.matchedLocation == Routes.login ||
          state.matchedLocation == Routes.otp;

      if (!isLoggedIn && !isAuthRoute && state.matchedLocation != Routes.splash) {
        return Routes.login;
      }
      return null;
    },
    routes: [
      // Splash → redirect
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashRedirect(),
      ),

      // Auth
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) {
          final mobile = state.extra as String? ?? '';
          return OtpPage(mobile: mobile);
        },
      ),

      // Main shell (bottom nav)
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: Routes.home,    builder: (_, __) => const HomePage()),
          GoRoute(path: Routes.search,  builder: (_, __) => const SearchPage()),
          GoRoute(path: Routes.quickBuy,builder: (_, __) => const SearchPage()), // placeholder
          GoRoute(path: Routes.orders,  builder: (_, __) => const OrdersPage()),
          GoRoute(path: Routes.profile, builder: (_, __) => const ProfilePage()),
        ],
      ),

      // Products
      GoRoute(
        path: Routes.productDetail,
        builder: (_, state) => ProductDetailPage(
          productId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.categoryDetail,
        builder: (_, state) => CategoryProductsPage(
          categoryId: int.parse(state.pathParameters['id']!),
          categoryName: state.extra as String? ?? '',
        ),
      ),

      // Cart & Checkout
      GoRoute(path: Routes.cart,     builder: (_, __) => const CartPage()),
      GoRoute(path: Routes.checkout, builder: (_, __) => const CheckoutPage()),

      // Orders
      GoRoute(
        path: Routes.orderDetail,
        builder: (_, state) => OrderDetailPage(
          orderId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Profile sub-pages
      GoRoute(path: Routes.addresses,     builder: (_, __) => const AddressesPage()),
      GoRoute(path: Routes.favorites,     builder: (_, __) => const FavoritesPage()),
      GoRoute(path: Routes.notifications, builder: (_, __) => const NotificationsPage()),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('صفحه یافت نشد: ${state.error}')),
    ),
  );
});

// ── Splash redirect ───────────────────────────────────────────────────────────

class SplashRedirect extends StatefulWidget {
  const SplashRedirect({super.key});

  @override
  State<SplashRedirect> createState() => _SplashRedirectState();
}

class _SplashRedirectState extends State<SplashRedirect> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    final storage = StorageService();
    if (storage.isLoggedIn) {
      context.go(Routes.home);
    } else {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

// ── Splash Screen ─────────────────────────────────────────────────────────────

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 160, errorBuilder: (_, __, ___) =>
              const Icon(Icons.shopping_basket, size: 100, color: Color(0xFF2E7D32))),
            const SizedBox(height: 24),
            const Text(
              'زبیلو',
              style: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'خرید آسان، تازه و سریع',
              style: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
