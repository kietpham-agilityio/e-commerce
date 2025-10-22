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

    if (path.startsWith('/rest/v1/rpc/get_home_products')) {
      _handleHomeApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/rest/v1/categories')) {
      _handleShopApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/rest/v1/products')) {
      _handleProductDetailsApi(options, handler, scenario);

      return;
    }

    if (path.startsWith('/rest/v1/rpc/get_related_products')) {
      _handleRelatedProductsApi(options, handler, scenario);

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

  /// Handle mock responses for Home API
  void _handleHomeApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiHome.mockError.toString()) {
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

    Map<String, dynamic> data;

    if (scenario == ApiHome.mockSuccess.toString()) {
      data = {
        "data": {
          "new_products": [
            {
              "id": 6,
              "name": "Floral Summer Dress",
              "description":
                  "Lightweight floral dress with a flattering A-line cut, perfect for warm weather.",
              "category_id": 1,
              "brand": "ZARA",
              "price": 59.99,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 30,
              "image_urls": [
                "https://images.pexels.com/photos/1055691/pexels-photo-1055691.jpeg",
                "https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg",
                "https://images.pexels.com/photos/1988681/pexels-photo-1988681.jpeg",
                "https://images.pexels.com/photos/1488467/pexels-photo-1488467.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 7,
              "name": "Evening Satin Gown",
              "description":
                  "Elegant long satin gown with open back and slim fit design for formal occasions.",
              "category_id": 1,
              "brand": "H&M",
              "price": 120,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 12,
              "image_urls": [
                "https://images.pexels.com/photos/2909096/pexels-photo-2909096.jpeg",
                "https://images.pexels.com/photos/2909117/pexels-photo-2909117.jpeg",
                "https://images.pexels.com/photos/2909103/pexels-photo-2909103.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 9,
              "name": "Leather Ankle Boots",
              "description":
                  "Premium leather ankle boots with non-slip soles and side zippers.",
              "category_id": 2,
              "brand": "Dr. Martens",
              "price": 150,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 40,
              "image_urls": [
                "https://images.pexels.com/photos/1456706/pexels-photo-1456706.jpeg",
                "https://images.pexels.com/photos/1456708/pexels-photo-1456708.jpeg",
                "https://images.pexels.com/photos/1456709/pexels-photo-1456709.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 11,
              "name": "Travel Backpack",
              "description":
                  "Durable and spacious travel backpack with multiple compartments and laptop sleeve.",
              "category_id": 3,
              "brand": "The North Face",
              "price": 110,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 50,
              "image_urls": [
                "https://images.pexels.com/photos/374906/pexels-photo-374906.jpeg",
                "https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg",
                "https://images.pexels.com/photos/267202/pexels-photo-267202.jpeg",
              ],
              "label": "NEW",
            },
          ],
          "discount_products": [
            {
              "id": 152,
              "name": "Running Sandals",
              "description": "Comfort sandals for sport and outdoor wear.",
              "category_id": 6,
              "brand": "Adidas",
              "price": 75,
              "discount": 15,
              "final_price": 63.75,
              "quantity": 130,
              "image_urls": [
                "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
                "https://images.pexels.com/photos/2529150/pexels-photo-2529150.jpeg",
                "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
              ],
              "label": "15%",
              "created_at": "2025-10-14T02:40:34.347529+00:00",
            },
            {
              "id": 138,
              "name": "Chuck Taylor All Star",
              "description": "Canvas high-top sneakers with rubber sole.",
              "category_id": 6,
              "brand": "Converse",
              "price": 70,
              "discount": 10,
              "final_price": 63,
              "quantity": 180,
              "image_urls": [
                "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
                "https://images.pexels.com/photos/2944535/pexels-photo-2944535.jpeg",
                "https://images.pexels.com/photos/292999/pexels-photo-292999.jpeg",
              ],
              "label": "10%",
              "created_at": "2025-10-14T02:40:34.347529+00:00",
            },
            {
              "id": 139,
              "name": "Old Skool",
              "description": "Classic skate shoes with side stripe design.",
              "category_id": 6,
              "brand": "Vans",
              "price": 75,
              "discount": 10,
              "final_price": 67.5,
              "quantity": 200,
              "image_urls": [
                "https://images.pexels.com/photos/1124465/pexels-photo-1124465.jpeg",
                "https://images.pexels.com/photos/1124466/pexels-photo-1124466.jpeg",
                "https://images.pexels.com/photos/1124464/pexels-photo-1124464.jpeg",
              ],
              "label": "10%",
              "created_at": "2025-10-14T02:40:34.347529+00:00",
            },
            {
              "id": 103,
              "name": "Denim Shorts",
              "description": "Casual denim shorts with frayed hem.",
              "category_id": 5,
              "brand": "Levi’s",
              "price": 55,
              "discount": 10,
              "final_price": 49.5,
              "quantity": 100,
              "image_urls": [
                "https://images.pexels.com/photos/116284/pexels-photo-116284.jpeg",
                "https://images.pexels.com/photos/631166/pexels-photo-631166.jpeg",
                "https://images.pexels.com/photos/631168/pexels-photo-631168.jpeg",
              ],
              "label": "10%",
              "created_at": "2025-10-14T02:29:56.807368+00:00",
            },
          ],
        },
      };
    } else {
      // Real API call
      super.onRequest(options, handler);

      return;
    }

    handler.resolve(
      Response(requestOptions: options, statusCode: 200, data: data),
    );
  }

  /// Handle mock responses for Shop API
  void _handleShopApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiShop.mockError.toString()) {
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
    if (scenario == ApiShop.mockSuccess.toString()) {
      data = [
        {
          "id": 1,
          "name": "Category 1",
          "description": "Fashion dresses for women",
          "parent_id": null,
        },
        {
          "id": 2,
          "name": "Category 2",
          "description": "Footwear for all genders",
          "parent_id": null,
        },
        {
          "id": 3,
          "name": "Category 3",
          "description": "Handbags and backpacks",
          "parent_id": null,
        },
        {
          "id": 4,
          "name": "Category 4",
          "description": "Jewelry, belts, hats",
          "parent_id": null,
        },
        {
          "id": 5,
          "name": "Category 5",
          "description": "Coats and jackets",
          "parent_id": null,
        },
        {"id": 6, "name": "Category 6", "description": null, "parent_id": null},
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

  /// Handle mock responses for Product Details API
  void _handleProductDetailsApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiProductDetails.mockError.toString()) {
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
    if (scenario == ApiProductDetails.mockSuccess.toString()) {
      data = [
        {
          "id": 6,
          "name": "Floral Summer Dress",
          "description":
              "Lightweight floral dress with a flattering A-line cut, perfect for warm weather.",
          "category_id": 1,
          "brand": "ZARA",
          "price": 59.99,
          "created_at": "2025-10-14T02:17:44.46308+00:00",
          "discount": 0,
          "quantity": 30,
          "image_urls": [
            "https://images.pexels.com/photos/1055691/pexels-photo-1055691.jpeg",
            "https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg",
            "https://images.pexels.com/photos/1988681/pexels-photo-1988681.jpeg",
            "https://images.pexels.com/photos/1488467/pexels-photo-1488467.jpeg",
          ],
          "label": "NEW",
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

  /// Handle mock responses for Related Products API
  void _handleRelatedProductsApi(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String scenario,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (scenario == ApiRelatedProducts.mockError.toString()) {
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

    Map<String, dynamic> data;
    if (scenario == ApiRelatedProducts.mockSuccess.toString()) {
      data = {
        "data": {
          "related_products": [
            {
              "id": 6,
              "name": "Floral Summer Dress",
              "description":
                  "Lightweight floral dress with a flattering A-line cut, perfect for warm weather.",
              "category_id": 1,
              "brand": "ZARA",
              "price": 59.99,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 30,
              "image_urls": [
                "https://images.pexels.com/photos/1055691/pexels-photo-1055691.jpeg",
                "https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg",
                "https://images.pexels.com/photos/1988681/pexels-photo-1988681.jpeg",
                "https://images.pexels.com/photos/1488467/pexels-photo-1488467.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 7,
              "name": "Evening Satin Gown",
              "description":
                  "Elegant long satin gown with open back and slim fit design for formal occasions.",
              "category_id": 1,
              "brand": "H&M",
              "price": 120,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 12,
              "image_urls": [
                "https://images.pexels.com/photos/2909096/pexels-photo-2909096.jpeg",
                "https://images.pexels.com/photos/2909117/pexels-photo-2909117.jpeg",
                "https://images.pexels.com/photos/2909103/pexels-photo-2909103.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 9,
              "name": "Leather Ankle Boots",
              "description":
                  "Premium leather ankle boots with non-slip soles and side zippers.",
              "category_id": 2,
              "brand": "Dr. Martens",
              "price": 150,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 40,
              "image_urls": [
                "https://images.pexels.com/photos/1456706/pexels-photo-1456706.jpeg",
                "https://images.pexels.com/photos/1456708/pexels-photo-1456708.jpeg",
                "https://images.pexels.com/photos/1456709/pexels-photo-1456709.jpeg",
              ],
              "label": "NEW",
            },
            {
              "id": 11,
              "name": "Travel Backpack",
              "description":
                  "Durable and spacious travel backpack with multiple compartments and laptop sleeve.",
              "category_id": 3,
              "brand": "The North Face",
              "price": 110,
              "created_at": "2025-10-14T02:17:44.46308+00:00",
              "discount": 0,
              "quantity": 50,
              "image_urls": [
                "https://images.pexels.com/photos/374906/pexels-photo-374906.jpeg",
                "https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg",
                "https://images.pexels.com/photos/267202/pexels-photo-267202.jpeg",
              ],
              "label": "NEW",
            },
          ],
        },
      };
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

enum ApiHome { real, mockSuccess, mockError }

enum ApiShop { real, mockSuccess, mockError }

enum ApiProductDetails { real, mockSuccess, mockError }

enum ApiRelatedProducts { real, mockSuccess, mockError }
