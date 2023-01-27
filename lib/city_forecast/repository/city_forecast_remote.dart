import 'package:klep_weather/city_forecast/model/city_forecast_list_remote_model.dart';
import 'package:klep_weather/network/rest_client.dart';

import '../../network/result.dart';

class CityForecastRemote {
  CityForecastRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<CityForecastRemoteModel>> loadCityForecastById(int id) async {
    try {
      final response = await _restClient.getForecastById(id: id);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET forecast request failed");
    }
  }
}
