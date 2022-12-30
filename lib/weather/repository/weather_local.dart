import 'package:klep_weather/database/database.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(Weather weather) => _database.addWeather(weather);

  Stream<List<Weather>> getWeatherModels() async* {
    yield* _database.observeWeathers();
  }
}
