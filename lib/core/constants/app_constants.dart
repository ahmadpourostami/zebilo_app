class AppConstants {
  AppConstants._();

  // ── API ───────────────────────────────────────────────────────────────────
  static const String baseUrl = 'https://api.zebilo.ir/wp-json/zebilo/v1';
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;

  // ── Storage Keys ──────────────────────────────────────────────────────────
  static const String tokenKey        = 'zebilo_access_token';
  static const String refreshTokenKey = 'zebilo_refresh_token';
  static const String userKey         = 'zebilo_user';
  static const String themeKey        = 'zebilo_theme';

  // ── Pagination ────────────────────────────────────────────────────────────
  static const int defaultPerPage = 20;

  // ── App ───────────────────────────────────────────────────────────────────
  static const String appName    = 'زبیلو';
  static const String appTagline = 'خرید آسان، تازه و سریع';
}

class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const sendOtp    = '/auth/send-otp';
  static const verifyOtp  = '/auth/verify-otp';
  static const refresh    = '/auth/refresh';
  static const logout     = '/auth/logout';

  // Home & Products
  static const home       = '/home';
  static const products   = '/products';
  static const categories = '/categories';
  static const search     = '/search';

  static String product(int id)           => '/products/$id';
  static String relatedProducts(int id)   => '/products/$id/related';
  static String categoryProducts(int id)  => '/categories/$id/products';

  // Cart
  static const cart       = '/cart';
  static const cartAdd    = '/cart/add';
  static String cartItem(int id) => '/cart/item/$id';

  // Orders
  static const checkout   = '/checkout';
  static const orders     = '/orders';
  static String order(int id)          => '/orders/$id';
  static String orderTracking(int id)  => '/orders/$id/tracking';
  static String orderReorder(int id)   => '/orders/$id/reorder';
  static String orderCancel(int id)    => '/orders/$id/cancel';

  // Addresses
  static const addresses  = '/addresses';
  static String address(int id)        => '/addresses/$id';
  static String addressDefault(int id) => '/addresses/$id/default';

  // Favorites
  static const favorites  = '/favorites';
  static String favorite(int id) => '/favorites/$id';

  // Notifications
  static const notifications          = '/notifications';
  static const notificationsReadAll   = '/notifications/read-all';
  static String notificationRead(int id) => '/notifications/$id/read';

  // Profile
  static const profile    = '/profile';

  // Coupons
  static const coupons          = '/coupons';
  static const couponsValidate  = '/coupons/validate';

  // Settings
  static const settings   = '/settings';
}
