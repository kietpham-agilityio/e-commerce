import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'test_apis.g.dart';

@RestApi()
abstract class TestApis {
  factory TestApis(Dio dio) = _TestApis;

  @POST('/posts')
  Future<dynamic> testApis({@Body() required Map<String, dynamic> body});

  @GET('/posts')
  Future<dynamic> getApis();
}
