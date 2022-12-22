import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
  })  : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;

}
