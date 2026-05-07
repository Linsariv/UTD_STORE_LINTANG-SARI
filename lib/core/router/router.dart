import 'package:go_router/go_router.dart';

// import halaman (nanti kamu sesuaikan path-nya)
import '../../features/product/presentation/pages/home_page.dart';
import '../../features/product/presentation/pages/splash_page.dart';
import '../../features/bookmark/presentation/pages/bookmark_page.dart';
import '../../features/crypto/presentation/pages/crypto_page.dart';
import 'package:utd_store_lintang_sari/features/cart/presentation/pages/cart_page.dart';
import 'package:utd_store_lintang_sari/features/battery/presentation/pages/battery_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // SPLASH
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),

    // HOME / PRODUCT
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),

    // BOOKMARK
    GoRoute(
      path: '/bookmark',
      builder: (context, state) => const BookmarkPage(),
    ),

    // CRYPTO
    GoRoute(
      path: '/crypto',
      builder: (context, state) => const CryptoPage(),
    ),

    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),

    GoRoute(
      path: '/battery',
      name: 'battery',
      builder: (context, state) => const BatteryPage(),
    ),
  ],
);