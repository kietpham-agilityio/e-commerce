import 'package:dio/dio.dart';

import '../core/api_mode.dart';

/// Interceptor that returns mocked responses when [ApiModeService.isMockMode]
/// is true. Uses [ApiModeService.currentScenarioType] to determine the variant
/// (e.g., 'success', 'empty', 'error').
class MockBackendInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (ApiModeService.isRealMode) {
      super.onRequest(options, handler);

      return;
    }

    final String scenario = ApiModeService.currentScenarioType ?? 'success';

    final String path = options.path;

    await Future.delayed(const Duration(milliseconds: 500));

    // Example default mocks
    if (path.startsWith('/posts')) {
      if (scenario == 'error') {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: options,
              statusCode: 500,
              data: {
                'error': 'Mocked server error',
                'code': 'MOCK_ERROR',
                'message': 'A mocked error occurred',
              },
            ),
          ),
        );

        return;
      }

      List<Map<String, dynamic>> data;

      if (scenario == 'empty') {
        data = [];
      } else {
        data = [
          {"userId": 1, "id": 1, "title": "Mock Title", "body": "Mock Body"},
        ];
      }

      handler.resolve(
        Response(requestOptions: options, statusCode: 200, data: data),
      );

      return;
    }

    super.onRequest(options, handler);
  }
}
