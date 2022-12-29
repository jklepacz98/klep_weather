import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/result.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(Weather weather) => _database.addWeather(weather);

  Future<Result<List<Weather>>> getWeatherModels() async {
    final weathers = await _database.getWeather();
    //todo
    return Result.success(weathers);
  }
}
