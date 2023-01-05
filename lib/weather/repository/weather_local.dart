import 'package:klep_weather/database/database.dart';

class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(Weather weather) => _database.addWeather(weather);

  Stream<Weather> observeWeather(int id) async* {
    yield* _database.observeWeather(id);
  }

  Stream<List<Weather>> observeWeathers() async* {
    yield* _database.observeWeathers();
  }

  Future<Weather> getWeather(int id) async => _database.getWeather(id);

  Future<List<Weather>> getWeathers() async => _database.getWeathers();
}
