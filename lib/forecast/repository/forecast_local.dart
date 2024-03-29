import 'package:injectable/injectable.dart';
import 'package:klep_weather/database/database.dart';

@lazySingleton
class ForecastLocal {
  ForecastLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> saveForecast(List<ForecastCompanion> forecastCompanionList) =>
      _database.addForecasts(forecastCompanionList);

  Future<void> removeForecastsByCityId(int cityId) =>
      _database.removeForecastsByCityId(cityId);

  Stream<List<Forecast>> observerForecastsByCityId(int cityId) =>
      _database.observeForecastsByCityId(cityId);
}
