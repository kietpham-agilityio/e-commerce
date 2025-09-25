import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:go_router/go_router.dart';

class RouterGuard {
  static Future<String?> authGuard(GoRouterState state) async {
    final unAuthenList = [
      state.namedLocation(AppPaths.login.name),
      state.namedLocation(AppPaths.signup.name),
    ];
    // TODO: handle redirect

    if (unAuthenList.contains(state.matchedLocation)) {
      return null;
    }

    return null;
  }
}
