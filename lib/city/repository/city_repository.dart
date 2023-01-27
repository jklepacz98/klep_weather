import 'package:klep_weather/city/entity/city_entity.dart';
import 'package:klep_weather/city/repository/city_local.dart';

class CityRepository {
  CityRepository({required CityLocal local}) : _local = local;

  final CityLocal _local;

  Future<void> saveCity(CityEntity cityEntity) =>
      _local.saveCity(cityEntity.toCityLocalModel());
}
