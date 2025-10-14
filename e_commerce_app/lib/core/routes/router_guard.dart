import 'package:e_commerce_app/core/di/auth_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/domain/usecases/auth_state_usecase.dart';
import 'package:ec_core/api_client/enums/supabase_enums.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RouterGuard {
  static final GetIt _getIt = GetIt.instance;

  static Future<String?> authGuard(GoRouterState state) async {
    // Public routes that don't require authentication
    final publicRoutes = [
      state.namedLocation(AppPaths.login.name),
      AppPaths.login.path,
    ];

    // Check if current route is public
    if (publicRoutes.contains(state.matchedLocation)) {
      return null;
    }

    // Check if user is authenticated
    if (!AuthModule.isRegistered) {
      // Auth module not yet registered, allow navigation
      return null;
    }

    try {
      final isAuthenticatedUseCase = _getIt<IsAuthenticatedUseCase>();
      final isAuthenticated = await isAuthenticatedUseCase();

      if (!isAuthenticated) {
        // Not authenticated, redirect to login
        return AppPaths.login.path;
      }

      // User is authenticated, check role-based access
      final getCurrentUserUseCase = _getIt<GetCurrentUserUseCase>();
      final user = await getCurrentUserUseCase();

      if (user == null) {
        // No user found, redirect to login
        return AppPaths.login.path;
      }

      // Check if user is trying to access admin routes
      final isAdminRoute = state.matchedLocation.startsWith('/admin');

      if (isAdminRoute && user.role != UserRole.admin) {
        // Non-admin trying to access admin route, redirect to home
        return AppPaths.home.path;
      }

      // Allow navigation
      return null;
    } catch (e) {
      // Error checking auth state, redirect to login
      return AppPaths.login.path;
    }
  }
}
