import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'user_apis.g.dart';

@RestApi()
abstract class UserApis {
  factory UserApis(Dio dio) = _UserApis;
}
