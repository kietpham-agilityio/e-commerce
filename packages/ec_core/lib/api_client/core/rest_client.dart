import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

/// Base Retrofit API client following the convention pattern
///
/// This abstract class serves as the base for all Retrofit API clients.
/// It provides common configuration and follows the user's preferred convention
/// of using @RestApi annotation with factory constructor.
@RestApi()
abstract class RestClient {
  /// Factory constructor to create RestClient instance
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;
}
