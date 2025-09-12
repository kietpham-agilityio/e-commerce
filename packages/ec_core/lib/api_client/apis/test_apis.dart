import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'test_apis.g.dart';

@RestApi()
abstract class TestApis {
  factory TestApis(Dio dio) = _TestApis;

  @GET('/posts')
  Future<dynamic> getApis();

  @GET('/comments')
  Future<dynamic> getComments(@Query('postId') int postId);
}
