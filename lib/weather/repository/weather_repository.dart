import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

import '../model/weather_model.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
  })
      : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;

  Future<Result<WeatherModel>> loadWeather() async {
    final result = await _weatherRemote.loadWeather();
    if (result.isSuccess) {
      final weather = result.value!;
      _weatherLocal.saveWeather(weather);
    }
    return result;
  }
}
