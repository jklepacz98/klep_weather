import 'package:klep_weather/database/database.dart';

class ForecastLocal {
  ForecastLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<int> saveForecast()
}