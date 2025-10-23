import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<EcHomeEntities> fetchHomeData() async {
    try {
      // Use the injected API client which is already configured with
      // Supabase URL and authentication headers via DI
      final response = await _apiClient.homeApi.getHome();

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
