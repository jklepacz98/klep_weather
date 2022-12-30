import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

import '../../database/database.dart';
import '../model/weather_model.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
  })  : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;

  Future<Result<WeatherModel>> loadWeather(String city) async {
    final result = await _weatherRemote.loadWeather(city);
    if (result.isSuccess) {
      final weatherModel = result.value!;
      _weatherLocal.saveWeather(weatherModel.toWeather());
    }
    return result;
  }

  Stream<List<Weather>> observerWeathers() async* {
    yield* _weatherLocal.getWeatherModels();
  }
}
