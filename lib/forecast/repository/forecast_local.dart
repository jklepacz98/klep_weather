import 'package:klep_weather/database/database.dart';

class ForecastLocal {
  ForecastLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> saveForecast(
          List<ForecastTableCompanion> forecastTableCompanionList) =>
      _database.addForecasts(forecastTableCompanionList);

  Future<void> removeForecastsByCityId(int cityId) =>
      _database.removeForecastsByCityId(cityId);

  Stream<List<Forecast>> observerForecasts() => _database.observeForecasts();
}
