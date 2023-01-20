import 'dart:async';

import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

import '../../database/database.dart';
import '../model/weather_model.dart';
import '../model/weather_models.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
  })  : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;

  Future<Result<WeatherModel>> loadWeatherByCity(String city) async {
    final result = await _weatherRemote.loadWeatherByCity(city);
    if (result.isSuccess) {
      final weatherModel = result.value!;
      _weatherLocal.saveWeather(weatherModel.toWeather());
    }
    return result;
  }

  Future<Result<WeatherModel>> loadWeatherById(int id) async {
    final result = await _weatherRemote.loadWeatherById(id);
    if (result.isSuccess) {
      final weatherModel = result.value!;
      _weatherLocal.saveWeather(weatherModel.toWeather());
    }
    return result;
  }

  Future<void> loadWeathersByIds(List<int> ids) async {
    final result = await _weatherRemote.loadWeathersByIds(ids);
    if (result.isSuccess) {
      final weatherModels = result.value!;
      final weathers = weatherModels.weatherList
          .map((weatherModel) => weatherModel.toWeather())
          .toList();
      _weatherLocal.saveWeathers(weathers);
    }
  }

  Stream<Weather> observeWeather(int id) async* {
    yield* _weatherLocal.observeWeather(id);
  }

  Stream<List<Weather>> observeWeathers() async* {
    yield* _weatherLocal.observeWeathers();
  }

  Future<Weather> getWeather(int id) => _weatherLocal.getWeather(id);

  Future<List<Weather>> getWeathers() => _weatherLocal.getWeathers();
}
