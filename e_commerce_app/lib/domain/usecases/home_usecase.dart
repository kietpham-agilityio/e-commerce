import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';

class HomeUseCase {
  const HomeUseCase({required HomeRepository homeRepository})
    : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  Future<EcHomeEntities> fetchHomeData() async {
    return await _homeRepository.fetchHomeData();
  }
}
