import 'package:injectable/injectable.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/model/weather_models.dart';

import '../model/weather_model.dart';

@lazySingleton
class WeatherRemote {
  WeatherRemote({required RestClient restClient}) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<WeatherModel>> loadWeatherByCity(
    String city,
    String language,
  ) async {
    try {
      final response = await _restClient.getWeatherByCity(
        city: city,
        language: language,
      );
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  Future<Result<WeatherModel>> loadWeatherById(
    int id,
    String language,
  ) async {
    try {
      final response = await _restClient.getWeatherById(
        id: id,
        language: language,
      );
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  //todo lang parameter doesn't affect city name, it works in other requests
  Future<Result<WeatherModels>> loadWeathersByIds(
    List<int> ids,
    String language,
  ) async {
    try {
      final response = await _restClient.getWeathersByIds(
        ids: ids,
        language: language,
      );
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather group request failed");
    }
  }
}
