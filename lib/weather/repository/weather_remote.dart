import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';

import '../model/weather_model.dart';

class WeatherRemote {
  WeatherRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<WeatherModel>> loadWeather(String city) async {
    try {
      final response = await _restClient.getWeatherByCity(city: city);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET weather request failed");
    }
  }
}
