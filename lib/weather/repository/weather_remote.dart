import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/model/weather_list_remote_model.dart';

import '../model/weather_remote_model.dart';

class WeatherRemote {
  WeatherRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<WeatherRemoteModel>> loadWeatherByCity(String city) async {
    try {
      final response = await _restClient.getWeatherByCity(city: city);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  Future<Result<WeatherRemoteModel>> loadWeatherById(int id) async {
    try {
      final response = await _restClient.getWeatherById(id: id);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }

  Future<Result<WeatherListRemoteModel>> loadWeathersByIds(
      List<int> ids) async {
    try {
      final response = await _restClient.getWeathersByIds(ids: ids);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather group request failed");
    }
  }
}
