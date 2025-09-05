import '../core/api_mode.dart';

/// Abstract API service interface
abstract class ApiService {
  Future<Map<String, dynamic>> get(String endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data);
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data);
  Future<Map<String, dynamic>> delete(String endpoint);
}

/// Real API service implementation
class RealApiService implements ApiService {
  final String baseUrl;

  RealApiService({required this.baseUrl});

  @override
  Future<Map<String, dynamic>> get(String endpoint) async {
    // Implement real API call
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay
    return {
      'data': 'Real API data from $endpoint',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'data': 'Real API POST response from $endpoint',
      'sentData': data,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'data': 'Real API PUT response from $endpoint',
      'sentData': data,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'data': 'Real API DELETE response from $endpoint',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// Mock API service implementation with scenario support
class MockApiService implements ApiService {
  MockApiService({this.scenarioType});

  final String? scenarioType;

  @override
  Future<Map<String, dynamic>> get(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 200));

    switch (scenarioType) {
      case 'empty':
        return _getEmptyResponse(endpoint);
      case 'success':
        return _getSuccessResponse(endpoint);
      case 'error':
        return _getErrorResponse(endpoint);
      default:
        return _getDefaultMockResponse(endpoint);
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));

    switch (scenarioType) {
      case 'empty':
        return _getEmptyResponse(endpoint);
      case 'success':
        return _getSuccessResponse(endpoint);
      case 'error':
        return _getErrorResponse(endpoint);
      default:
        return _getDefaultMockResponse(endpoint);
    }
  }

  @override
  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));

    switch (scenarioType) {
      case 'empty':
        return _getEmptyResponse(endpoint);
      case 'success':
        return _getSuccessResponse(endpoint);
      case 'error':
        return _getErrorResponse(endpoint);
      default:
        return _getDefaultMockResponse(endpoint);
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 200));

    switch (scenarioType) {
      case 'empty':
        return _getEmptyResponse(endpoint);
      case 'success':
        return _getSuccessResponse(endpoint);
      case 'error':
        return _getErrorResponse(endpoint);
      default:
        return _getDefaultMockResponse(endpoint);
    }
  }

  Map<String, dynamic> _getEmptyResponse(String endpoint) {
    return {
      'data': {},
      'message': 'No data available',
      'isMock': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> _getSuccessResponse(String endpoint) {
    return {
      'data': {
        'id': 123,
        'name': 'John Doe',
        'email': 'john@example.com',
        'status': 'active',
        'lastLogin':
            DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      },
      'message': 'Successfully retrieved data',
      'isMock': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> _getErrorResponse(String endpoint) {
    return {
      'error': {
        'code': 'MOCK_ERROR',
        'message': 'Simulated error for testing',
        'details': 'This is a mock error response',
      },
      'isMock': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> _getDefaultMockResponse(String endpoint) {
    return {
      'data': 'Mock API data from $endpoint',
      'isMock': true,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

/// API service factory that switches between real and mock based on ApiModeService
class ApiServiceFactory {
  static ApiService createService({
    required String baseUrl,
    ApiMode? mode,
    String? scenarioType,
  }) {
    final apiMode = mode ?? ApiModeService.currentMode;

    switch (apiMode) {
      case ApiMode.real:
        return RealApiService(baseUrl: baseUrl);
      case ApiMode.mock:
        return MockApiService(scenarioType: scenarioType);
    }
  }
}
