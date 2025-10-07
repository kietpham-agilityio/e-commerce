import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/base_response.dart';

part 'test_simple_api.g.dart';

/// Simple test API to verify Retrofit setup
@RestApi()
abstract class TestSimpleApi {
  factory TestSimpleApi(Dio dio, {String? baseUrl}) = _TestSimpleApi;

  /// Simple GET endpoint
  @GET('/test')
  Future<BaseResponseDto<String>> getTest();

  /// Simple POST endpoint
  @POST('/test')
  Future<BaseResponseDto<String>> postTest(@Body() Map<String, dynamic> data);
}
