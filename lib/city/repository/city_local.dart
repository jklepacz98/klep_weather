import 'package:klep_weather/database/database.dart';

class CityLocal {
  CityLocal({required AppDatabase database}) : _database = database;

  final AppDatabase _database;

  Future<void> saveCity(CityLocalModel cityLocalModel) =>
      _database.addCity(cityLocalModel);
}
