import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'home_apis.g.dart';

@RestApi()
abstract class HomeApis {
  factory HomeApis(Dio dio) = _HomeApis;

  /// ---------- Get Categories ----------
  @GET('/api/categories')
  Future<List<String>?> getCategories({
    @Query('searchBy') String searchBy = '',
  });

  /// ---------- Get Brands ----------
  @GET('/api/brands')
  Future<List<String>?> getBrands({@Query('searchBy') String searchBy = ''});
}
