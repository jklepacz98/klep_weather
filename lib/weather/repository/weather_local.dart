import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/result.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(Weather weather) =>
      _database.addWeather(weather);

  Future<Result<List<Weather>>> getWeatherModels() async {
    final weather = await _database.getWeather();
    return weather != null
        ? Result.success(weather)
        : Result.failure('Weather not found', 110);
  }
}
