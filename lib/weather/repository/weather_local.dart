import 'package:injectable/injectable.dart';
import 'package:klep_weather/database/database.dart';

@lazySingleton
class WeatherLocal {
  WeatherLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveWeather(Weather weather) => _database.addWeather(weather);

  Future<void> saveWeathers(List<Weather> weatherList) =>
      _database.addWeathers(weatherList);

  Stream<Weather> observeWeather(int id) async* {
    yield* _database.observeWeather(id);
  }

  Stream<List<Weather>> observeWeathers() async* {
    yield* _database.observeWeathers();
  }

  Future<Weather> getWeather(int id) async => _database.getWeather(id);

  Future<List<Weather>> getWeathers() async => _database.getWeathers();

  Future<void> removeWeather(int cityId) async =>
      _database.removeWeatherByCityId(cityId);
}
