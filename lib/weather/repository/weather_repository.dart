import 'dart:async';

import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';
import 'package:klep_weather/weather/model/weather_model.dart';
import 'package:klep_weather/weather/model/weather_models.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
    required LanguagePreferences languagePreferences,
  })  : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal,
        _languagePreferences = languagePreferences;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;
  final LanguagePreferences _languagePreferences;

  Future<Result<WeatherModel>> loadWeatherByCity(String city) async {
    final language = _languagePreferences.getLanguage();
    final result = await _weatherRemote.loadWeatherByCity(city, language);
    if (result.isSuccess) {
      final weatherModel = result.value!;
      await _weatherLocal.saveWeather(weatherModel.toWeather());
    }
    return result;
  }

  Future<Result<WeatherModel>> loadWeatherById(int id) async {
    final language = _languagePreferences.getLanguage();
    final result = await _weatherRemote.loadWeatherById(id, language);
    if (result.isSuccess) {
      final weatherModel = result.value!;
      await _weatherLocal.saveWeather(weatherModel.toWeather());
    }
    return result;
  }

  Future<Result<WeatherModels>> loadWeathersByIds(List<int> ids) async {
    final language = _languagePreferences.getLanguage();
    final result = await _weatherRemote.loadWeathersByIds(ids, language);
    if (result.isSuccess) {
      final weatherModels = result.value!;
      final weathers = weatherModels.weatherList
          .map((weatherModel) => weatherModel.toWeather())
          .toList();
      await _weatherLocal.saveWeathers(weathers);
    }
    return result;
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
