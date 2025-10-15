import 'package:dio/dio.dart';
import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/apis/home_api.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox;

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;

  @override
  Future<EcHomeEntities> fetchHomeData() async {
    try {
      // final response = await _apiClient.homeApi.getHome();

      // final discountProducts =
      //     response.data.discountProducts
      //         .asMap()
      //         .entries
      //         .map((entry) => entry.value.toEcProduct())
      //         .toList();

      // final newProducts =
      //     response.data.discountProducts
      //         .asMap()
      //         .entries
      //         .map((entry) => entry.value.toEcProduct())
      //         .toList();

      // FIXME: use _apiClient after fixing
      final baseUrl = dotenv.env['SUPABASE_URL'] ?? '';
      Dio();

      final dio = Dio();
      // dio.options.baseUrl = baseUrl;
      dio.options = BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'apikey': dotenv.env['SUPABASE_ANON_KEY'],
          'Authorization': 'Bearer ${dotenv.env['SUPABASE_ANON_KEY']}',
        },
      );

      final response = await HomeApi(dio).getHome();

      final discountProducts =
          response.data.discountProducts
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      final newProducts =
          response.data.newProducts
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      return EcHomeEntities(
        discountProducts: discountProducts,
        newProducts: newProducts,
      );
    } catch (e) {
      throw Failure('Failed to fetch home data');
    }
  }
}
