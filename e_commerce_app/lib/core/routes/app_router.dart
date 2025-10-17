import 'package:e_commerce_app/core/routes/router_guard.dart';
import 'package:e_commerce_app/presentations/bag/bag_page.dart';
import 'package:e_commerce_app/presentations/favorites/favorites_page.dart';
import 'package:e_commerce_app/presentations/home/home_page.dart';
import 'package:e_commerce_app/presentations/login/login_page.dart';
import 'package:e_commerce_app/presentations/product_details/product_details_page.dart';
import 'package:e_commerce_app/presentations/profile/profile_page.dart';
import 'package:e_commerce_app/presentations/shop/shop_page.dart';
import 'package:ec_themes/themes/widgets/bottom_navigation_bar/layout_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppPaths.login.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: AppPaths.login.name,
        path: AppPaths.login.path,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppPaths.productDetails.name,
        path: AppPaths.productDetails.path,
        builder: (context, state) {
          final productId = state.uri.queryParameters['productId'];

          return ProductDetailsPage(productId: productId ?? '');
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
                name: AppPaths.home.name,
                path: AppPaths.home.path,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppPaths.shop.name,
                path: AppPaths.shop.path,
                builder: (context, state) => const ShopPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppPaths.bag.name,
                path: AppPaths.bag.path,
                builder: (context, state) => const BagPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppPaths.favorites.name,
                path: AppPaths.favorites.path,
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppPaths.profile.name,
                path: AppPaths.profile.path,
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
}

enum AppPaths {
  login(name: 'login', path: '/login'),
  home(name: 'home', path: '/home'),
  shop(name: 'shop', path: '/shop'),
  bag(name: 'bag', path: '/bag'),
  favorites(name: 'favorites', path: '/favorites'),
  profile(name: 'profile', path: '/profile'),
  productDetails(name: 'productDetails', path: '/productDetails');

  const AppPaths({required this.name, required this.path});

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
