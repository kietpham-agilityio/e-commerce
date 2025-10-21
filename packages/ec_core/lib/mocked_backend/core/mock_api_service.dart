import 'package:ec_core/mocked_backend/interceptors/mock_backend_interceptor.dart';

import 'api_mode.dart';
import 'mock_api.dart';
import 'mock_scenario.dart';

/// Service to manage mock APIs and scenarios globally across the app
class MockApiService {
  MockApiService._internal();

  static final MockApiService _instance = MockApiService._internal();

  factory MockApiService() => _instance;

  static final List<MockApi<dynamic>> _apis = [
    const MockApi<ApiPosts>(
      name: 'Posts',
      path: '/posts',
      scenarios: [
        MockScenario<ApiPosts>(
          name: 'Real API',
          description: 'Use real API endpoint',
          payload: ApiPosts.real,
          apiMode: ApiMode.real,
        ),
        MockScenario<ApiPosts>(
          name: 'Mock Success',
          description: 'Mock successful response with data',
          payload: ApiPosts.mockSuccess,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiPosts>(
          name: 'Mock Empty',
          description: 'Mock empty response',
          payload: ApiPosts.mockEmpty,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiPosts>(
          name: 'Mock Error',
          description: 'Mock error response',
          payload: ApiPosts.mockError,
          apiMode: ApiMode.mock,
        ),
      ],
    ),
    const MockApi<ApiComments>(
      name: 'Comments',
      path: '/comments',
      scenarios: [
        MockScenario<ApiComments>(
          name: 'Real API',
          description: 'Use real API endpoint',
          payload: ApiComments.real,
          apiMode: ApiMode.real,
        ),
        MockScenario<ApiComments>(
          name: 'Mock Success',
          description: 'Mock successful response with data',
          payload: ApiComments.mockSuccess,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiComments>(
          name: 'Mock Empty',
          description: 'Mock empty response',
          payload: ApiComments.mockEmpty,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiComments>(
          name: 'Mock Error',
          description: 'Mock error response',
          payload: ApiComments.mockError,
          apiMode: ApiMode.mock,
        ),
      ],
    ),
    const MockApi<ApiHome>(
      name: 'Home',
      path: '/rest/v1/rpc/get_home_products',
      scenarios: [
        MockScenario<ApiHome>(
          name: 'Real API',
          description: 'Use real API endpoint',
          payload: ApiHome.real,
          apiMode: ApiMode.real,
        ),
        MockScenario<ApiHome>(
          name: 'Mock Success',
          description: 'Mock successful response with data',
          payload: ApiHome.mockSuccess,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiHome>(
          name: 'Mock Error',
          description: 'Mock error response',
          payload: ApiHome.mockError,
          apiMode: ApiMode.mock,
        ),
      ],
    ),
    const MockApi<ApiShop>(
      name: 'Shop',
      path: '/rest/v1/categories',
      scenarios: [
        MockScenario<ApiShop>(
          name: 'Real API',
          description: 'Use real API endpoint',
          payload: ApiShop.real,
          apiMode: ApiMode.real,
        ),
        MockScenario<ApiShop>(
          name: 'Mock Success',
          description: 'Mock successful response with data',
          payload: ApiShop.mockSuccess,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiShop>(
          name: 'Mock Error',
          description: 'Mock error response',
          payload: ApiShop.mockError,
          apiMode: ApiMode.mock,
        ),
      ],
    ),
    const MockApi<ApiFeatureFlags>(
      name: 'Feature Flags',
      path: '/rest/v1/feature_flags',
      scenarios: [
        MockScenario<ApiFeatureFlags>(
          name: 'Real API',
          description: 'Use real API endpoint',
          payload: ApiFeatureFlags.real,
          apiMode: ApiMode.real,
        ),
        MockScenario<ApiFeatureFlags>(
          name: 'Mock Success',
          description: 'Mock successful response with feature flags',
          payload: ApiFeatureFlags.mockSuccess,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiFeatureFlags>(
          name: 'Mock Empty',
          description: 'Mock empty response (no flags)',
          payload: ApiFeatureFlags.mockEmpty,
          apiMode: ApiMode.mock,
        ),
        MockScenario<ApiFeatureFlags>(
          name: 'Mock Error',
          description: 'Mock error response',
          payload: ApiFeatureFlags.mockError,
          apiMode: ApiMode.mock,
        ),
      ],
    ),
  ];

  /// Get all available mock APIs
  static List<MockApi<dynamic>> get apis => List.unmodifiable(_apis);
}
