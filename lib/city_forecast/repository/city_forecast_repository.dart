import 'package:klep_weather/city_forecast/entity/city_forecast_entity.dart';
import 'package:klep_weather/city_forecast/repository/city_forecast_remote.dart';
import 'package:klep_weather/network/result.dart';

class CityForecastRepository {
  CityForecastRepository({required CityForecastRemote cityForecastRemote})
      : _cityForecastRemote = cityForecastRemote;

  final CityForecastRemote _cityForecastRemote;

  Future<Result<CityForecastEntity>> loadForecastListById(int id) async {
    final remoteResult = await _cityForecastRemote.loadCityForecastById(id);
    if (remoteResult.isSuccess) {
      final remoteModel = remoteResult.value!;
      final entity =
          CityForecastEntity.fromCityForecastRemoteModel(remoteModel);
      return Result.success(entity);
    } else {
      return Result.failure(remoteResult.failure!.reason);
    }
  }
}
