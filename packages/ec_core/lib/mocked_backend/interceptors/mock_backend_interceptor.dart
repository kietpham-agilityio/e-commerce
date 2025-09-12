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
    final String path = options.path;
    final String scenario = ApiModeService.getScenarioForApi(path) ?? 'real';

    // Route to specific API handlers
    if (path.startsWith('/posts')) {
      _handlePostsApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/comments')) {
      _handleCommentsApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/post')) {
      _handlePostsApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/comment')) {
      _handlePostsApi(options, handler, scenario);

      return;
    }

    // No mock available, call real API
    super.onRequest(options, handler);
  }

  /// Handle mock responses for Posts API
  void _handlePostsApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiPosts.mockError.toString()) {
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

    if (scenario == ApiPosts.mockEmpty.toString()) {
      data = [];
    } else if (scenario == ApiPosts.mockSuccess.toString()) {
      data = [
        {"userId": 1, "id": 1, "title": "Mock Title", "body": "Mock Body"},
      ];
    } else {
      // Real API call
      super.onRequest(options, handler);
      return;
    }

    handler.resolve(
      Response(requestOptions: options, statusCode: 200, data: data),
    );
  }

  /// Handle mock responses for Comments API
  void _handleCommentsApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiComments.mockError.toString()) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: options,
            statusCode: 500,
            data: {
              'error': 'Mocked comments error',
              'code': 'MOCK_COMMENTS_ERROR',
              'message': 'A mocked comments error occurred',
            },
          ),
        ),
      );

      return;
    }

    List<Map<String, dynamic>> data;

    if (scenario == ApiComments.mockEmpty.toString()) {
      data = [];
    } else if (scenario == ApiComments.mockSuccess.toString()) {
      data = [
        {
          "postId": 1,
          "id": 1,
          "name": "Mock Commenter",
          "email": "mock@example.com",
          "body": "This is a mock comment for testing purposes.",
        },
        {
          "postId": 1,
          "id": 2,
          "name": "Another Mock User",
          "email": "another@example.com",
          "body": "Another mock comment to test the UI.",
        },
      ];
    } else {
      // Real API call
      super.onRequest(options, handler);

      return;
    }

    handler.resolve(
      Response(requestOptions: options, statusCode: 200, data: data),
    );
  }
}

enum ApiPosts { real, mockSuccess, mockEmpty, mockError }

enum ApiComments { real, mockSuccess, mockEmpty, mockError }
