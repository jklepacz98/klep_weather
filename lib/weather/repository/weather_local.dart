import 'package:klep_weather/database/database.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(WeatherLocalModel weather) =>
      _database.addWeather(weather);

  Future<void> saveWeatherList(List<WeatherLocalModel> weatherList) =>
      _database.addWeathers(weatherList);

  Stream<WeatherLocalModel> observeWeather(int id) async* {
    yield* _database.observeWeather(id);
  }

  Stream<List<WeatherLocalModel>> observeWeatherList() async* {
    yield* _database.observeWeathers();
  }

  Future<WeatherLocalModel> getWeather(int id) async =>
      _database.getWeather(id);

  Future<List<WeatherLocalModel>> getWeatherList() async =>
      _database.getWeathers();
}
