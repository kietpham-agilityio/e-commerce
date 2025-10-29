import 'package:e_commerce_app/core/routes/router_guard.dart';
import 'package:e_commerce_app/presentations/admin/login/login_page.dart';
import 'package:e_commerce_app/presentations/user/bag/bag_page.dart';
import 'package:e_commerce_app/presentations/user/favorites/favorites_page.dart';
import 'package:e_commerce_app/presentations/user/home/home_page.dart';
import 'package:e_commerce_app/presentations/user/login/login_page.dart';
import 'package:e_commerce_app/presentations/user/product_details/product_details_page.dart';
import 'package:e_commerce_app/presentations/user/profile/profile_page.dart';
import 'package:e_commerce_app/presentations/user/shop/shop_page.dart';
import 'package:ec_themes/themes/widgets/bottom_navigation_bar/layout_scaffold.dart';
import 'package:ec_themes/themes/widgets/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: UserAppPaths.login.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: UserAppPaths.login.name,
        path: UserAppPaths.login.path,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: UserAppPaths.productDetails.name,
        path: UserAppPaths.productDetails.path,
        builder: (context, state) {
          final productId = state.uri.queryParameters['productId'];
          final categoryId = state.uri.queryParameters['categoryId'];

          return ProductDetailsPage(
            productId: productId ?? '',
            categoryId: categoryId ?? '',
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                LayoutScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: UserAppPaths.home.name,
                path: UserAppPaths.home.path,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: UserAppPaths.shop.name,
                path: UserAppPaths.shop.path,
                builder: (context, state) => const ShopPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: UserAppPaths.bag.name,
                path: UserAppPaths.bag.path,
                builder: (context, state) => const BagPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: UserAppPaths.favorites.name,
                path: UserAppPaths.favorites.path,
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: UserAppPaths.profile.name,
                path: UserAppPaths.profile.path,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('Error: No route found'))),
    redirect: (context, state) {
      return RouterGuard.authGuard(state);
    },
  );

  static final adminRouter = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AdminAppPaths.login.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: AdminAppPaths.login.name,
        path: AdminAppPaths.login.path,
        builder: (context, state) => const AdminLoginPage(),
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('Error: No route found'))),
    redirect: (context, state) {
      return RouterGuard.adminAuthGuard(state);
    },
  );
}

enum UserAppPaths {
  login(name: 'login', path: '/login'),
  home(name: 'home', path: '/home'),
  shop(name: 'shop', path: '/shop'),
  bag(name: 'bag', path: '/bag'),
  favorites(name: 'favorites', path: '/favorites'),
  profile(name: 'profile', path: '/profile'),
  productDetails(name: 'productDetails', path: '/productDetails');

  const UserAppPaths({required this.name, required this.path});

  /// Represents the route name
  ///
  /// Example: `AppRoutes.login.name`
  /// Returns: 'login'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.login.path`
  /// Returns: '/login'
  final String path;

  @override
  String toString() => name;
}

enum AdminAppPaths {
  login(name: 'login', path: '/login');

  const AdminAppPaths({required this.name, required this.path});

  /// Represents the route name
  ///
  /// Example: `AppRoutes.login.name`
  /// Returns: 'login'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.login.path`
  /// Returns: '/login'
  final String path;

  @override
  String toString() => name;
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EcBodyLargeText(
          'Admin',
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
