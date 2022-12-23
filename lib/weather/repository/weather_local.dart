import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/result.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeatherModel(WeatherModel weatherModel) =>
      _database.addWeather(weatherModel);

  Future<Result<WeatherModel>> getWeatherModels() async {
    final weatherModel = await _database.ge
  }
}
