import 'package:klep_weather/database/database.dart';

class GeocodingLocal{
  GeocodingLocal({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;
}