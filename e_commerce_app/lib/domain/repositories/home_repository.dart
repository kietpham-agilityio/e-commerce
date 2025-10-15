import 'package:e_commerce_app/domain/entities/home_entities.dart';

abstract class HomeRepository {
  Future<EcHomeEntities> fetchHomeData();
}
