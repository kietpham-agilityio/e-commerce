import 'dart:developer';

import 'package:ec_core/services/ec_notifications/ec_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/api_service.dart';

/// Service module for registering business logic services
class ServiceModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register all services
  static void registerServices() {
    // Register Supabase client as singleton
    _getIt.registerLazySingleton<SupabaseClient>(
      () => Supabase.instance.client,
    );

    // Register ApiService as singleton
    _getIt.registerLazySingleton<ApiService>(() => ApiService());

    _getIt.registerLazySingleton<NotificationsService>(
      () =>
          NotificationsService()
            ..initialize()
            ..configure(
              onTap: (value) {
                NotificationHandler.navigate(
                  notification: value,
                  onOrderDetailsTap: (notifsRes) {
                    // TODO: Handle the notification tap after setup go_router
                    log('Handle the notification tap after setup go_router');
                  },
                );
              },
            ),
    );

    // Register other services here as needed
    // Example:
    // _getIt.registerLazySingleton<UserRepository>(
    //   () => UserRepository(),
    // );
    // _getIt.registerLazySingleton<AuthService>(
    //   () => AuthService(),
    // );
  }

  /// Get ApiService instance
  static ApiService get apiService => _getIt<ApiService>();

  /// Get NotificationsService instance
  static NotificationsService get notificationsService =>
      _getIt<NotificationsService>();

  /// Check if services are registered
  static bool get isRegistered =>
      _getIt.isRegistered<SupabaseClient>() &&
      _getIt.isRegistered<ApiService>();

  /// Reset all services (useful for testing)
  static void reset() {
    if (_getIt.isRegistered<ApiService>()) {
      _getIt.unregister<ApiService>();
    }
  }
}
