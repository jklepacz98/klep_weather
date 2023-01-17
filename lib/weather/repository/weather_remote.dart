import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/model/weather_models.dart';

import '../model/weather_model.dart';

class WeatherRemote {
  WeatherRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<WeatherModel>> loadWeatherByCity(String city) async {
    try {
      final response = await _restClient.getWeatherByCity(city: city);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  Future<Result<WeatherModel>> loadWeatherById(int id) async {
    try {
      final response = await _restClient.getWeatherById(id: id);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  Future<Result<WeatherModels>> loadWeathersByIds(List<int> ids) async {
    try {
      final response = await _restClient.getWeathersByIds(ids: ids);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather group request failed");
    }
  }
}
