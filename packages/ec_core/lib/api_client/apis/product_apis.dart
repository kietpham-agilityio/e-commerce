import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'product_apis.g.dart';

@RestApi()
abstract class ProductApis {
  factory ProductApis(Dio dio) = _ProductApis;

  
}
