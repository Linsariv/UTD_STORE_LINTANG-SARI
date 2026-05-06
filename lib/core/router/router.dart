import 'package:go_router/go_router.dart';

// import halaman (nanti kamu sesuaikan path-nya)
import '../../features/product/presentation/pages/home_page.dart';
import '../../features/product/presentation/pages/splash_page.dart';
import '../../features/bookmark/presentation/pages/bookmark_page.dart';
import '../../features/crypto/presentation/pages/crypto_page.dart';

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
  ],
);