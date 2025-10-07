import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ecommerce_api.g.dart';

/// Main E-Commerce API client for general endpoints
@RestApi()
abstract class EcommerceApi {
  factory EcommerceApi(Dio dio, {String? baseUrl}) = _EcommerceApi;

  // ============================================================================
  // TEST API ENDPOINTS
  // ============================================================================

  /// Get posts from test API
  @GET('/posts')
  Future<dynamic> getApis();

  /// Get comments from test API
  @GET('/comments')
  Future<dynamic> getComments(@Query('postId') int postId);
}
