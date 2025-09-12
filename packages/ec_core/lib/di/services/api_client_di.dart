import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../api_client/core/api_client.dart';
import '../../api_client/core/api_client_factory.dart';
import '../../ec_flavor.dart';
import '../di_initializer.dart';

/// API client dependency injection configuration
/// Provides centralized API client registration and management
class ApiClientDI {
  /// Register API clients for all environments and flavors
  static void registerApiClients({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
    bool enableLogging = true,
  }) {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register main API client
    _registerMainApiClient(
      flavor: currentFlavor,
      customHeaders: customHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      customInterceptors: customInterceptors,
      enableLogging: enableLogging,
    );
  }

  /// Register main API client
  static void _registerMainApiClient({
    required EcFlavor flavor,
    Map<String, String>? customHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
    required bool enableLogging,
  }) {
    final talker =
        enableLogging && DI.isRegistered<Talker>() ? DI.get<Talker>() : null;

    final apiClient = ApiClientFactory.createForCurrentFlavor(
      additionalHeaders: customHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: customInterceptors,
      talker: talker,
    );

    DI.registerService<ApiClient>(apiClient, instanceName: 'main');
  }

  /// Register authenticated API client
  static void registerAuthenticatedApiClient({
    required String token,
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
    bool enableLogging = true,
  }) {
    final currentFlavor = flavor ?? EcFlavor.current;
    final talker =
        enableLogging && DI.isRegistered<Talker>() ? DI.get<Talker>() : null;

    final authClient = ApiClientFactory.createWithAuth(
      token: token,
      environment: currentFlavor.environment,
      additionalHeaders: customHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: customInterceptors,
      talker: talker,
    );

    DI.registerService<ApiClient>(authClient, instanceName: 'authenticated');
  }

  /// Register custom API client
  static void registerCustomApiClient({
    required String baseUrl,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    bool enableLogging = true,
    String instanceName = 'custom',
  }) {
    final talker =
        enableLogging && DI.isRegistered<Talker>() ? DI.get<Talker>() : null;

    final customClient = ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    DI.registerService<ApiClient>(customClient, instanceName: instanceName);
  }

  /// Get API client by instance name
  static ApiClient getApiClient({String instanceName = 'main'}) {
    return DI.get<ApiClient>(instanceName: instanceName);
  }

  /// Get main API client
  static ApiClient get mainApiClient => getApiClient(instanceName: 'main');

  /// Get authenticated API client
  static ApiClient get authenticatedApiClient =>
      getApiClient(instanceName: 'authenticated');

  /// Check if API client is registered
  static bool isApiClientRegistered({String instanceName = 'main'}) {
    return DI.isRegistered<ApiClient>(instanceName: instanceName);
  }

  /// Unregister API client
  static void unregisterApiClient({String instanceName = 'main'}) {
    if (isApiClientRegistered(instanceName: instanceName)) {
      final client = DI.get<ApiClient>(instanceName: instanceName);
      client.dispose();
      DI.unregister<ApiClient>(instanceName: instanceName);
    }
  }

  /// Dispose all API clients
  static Future<void> disposeAllApiClients() async {
    final instanceNames = ['main', 'authenticated'];

    for (final instanceName in instanceNames) {
      unregisterApiClient(instanceName: instanceName);
    }
  }
}
