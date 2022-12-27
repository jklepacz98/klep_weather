import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';

import '../model/weather_model.dart';

class WeatherRemote {
  WeatherRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  //todo add city parameter
  Future<Result<WeatherModel>> loadWeather() async {
    // Future<Result<WeatherModel>> loadWeather(String city,) async {
    try {
      print("something3");
      final response = await _restClient.getWeatherByCity();
      print("something4");
      return Result.success(response);
    } on Exception catch (_) {
      //todo
      return Result.failure("Get weather failed", 114);
    }
  }
}
