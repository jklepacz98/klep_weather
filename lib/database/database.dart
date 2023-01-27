import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class WeatherLocalModels extends Table {
  RealColumn get coordLon => real()();

  RealColumn get coordLat => real()();

  IntColumn get weatherInfoId => integer()();

  TextColumn get weatherInfoMain => text()();

  TextColumn get weatherInfoDescription => text()();

  TextColumn get weatherInfoIcon => text()();

  RealColumn get mainInfoTemp => real()();

  RealColumn get mainInfoFeelsLike => real()();

  RealColumn get mainInfoTempMin => real()();

  RealColumn get mainInfoTempMax => real()();

  IntColumn get mainInfoPressure => integer()();

  IntColumn get mainInfoHumidity => integer()();

  IntColumn get visibility => integer()();

  RealColumn get windSpeed => real()();

  IntColumn get windDeg => integer()();

  IntColumn get cloudsAll => integer()();

  IntColumn get dt => integer()();

  IntColumn get id => integer()();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ForecastLocalModels extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get cityId => integer()();

  RealColumn get mainInfoTemp => real()();

  RealColumn get mainInfoFeelsLike => real()();

  RealColumn get mainInfoTempMin => real()();

  RealColumn get mainInfoTempMax => real()();

  IntColumn get mainInfoPressure => integer()();

  IntColumn get mainInfoHumidity => integer()();

  IntColumn get weatherInfoId => integer()();

  TextColumn get weatherInfoMain => text()();

  TextColumn get weatherInfoDescription => text()();

  TextColumn get weatherInfoIcon => text()();

  IntColumn get cloudsAll => integer()();

  RealColumn get windSpeed => real()();

  IntColumn get windDeg => integer()();

  IntColumn get visibility => integer()();

  IntColumn get dt => integer()();
}

class CityLocalModels extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, "db.sqlite"));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
    tables: [WeatherLocalModels, ForecastLocalModels, CityLocalModels])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addWeather(WeatherLocalModel weather) =>
      into(weatherLocalModels).insertOnConflictUpdate(weather);

  Future<void> addWeathers(List<WeatherLocalModel> weatherList) async {
    await batch(
      (batch) {
        batch.insertAllOnConflictUpdate(weatherLocalModels, weatherList);
      },
    );
  }

  Stream<WeatherLocalModel> observeWeather(int id) =>
      (select(weatherLocalModels)..where((tbl) => tbl.id.equals(id)))
          .watchSingle();

  Stream<List<WeatherLocalModel>> observeWeathers() =>
      select(weatherLocalModels).watch();

  //todo not used
  Future<WeatherLocalModel> getWeather(int id) =>
      (select(weatherLocalModels)..where((tbl) => tbl.id.equals(id)))
          .getSingle();

  //todo not used
  Future<List<WeatherLocalModel>> getWeathers() =>
      select(weatherLocalModels).get();

  Future<void> addForecasts(
      List<ForecastLocalModelsCompanion> forecastTableCompanionList) async {
    await batch(
      (batch) {
        batch.insertAllOnConflictUpdate(
            forecastLocalModels, forecastTableCompanionList);
      },
    );
  }

  //todo by cityId???
  Stream<List<ForecastLocalModel>> observeForecastsByCityId(int cityId) =>
      (select(forecastLocalModels)..where((tbl) => tbl.cityId.equals(cityId)))
          .watch();

  Future<void> removeForecastsByCityId(int cityId) =>
      (delete(forecastLocalModels)..where((tbl) => tbl.cityId.equals(cityId)))
          .go();

  Future<void> addCity(CityLocalModel cityLocalModel) =>
      into(cityLocalModels).insertOnConflictUpdate(cityLocalModel);

  Future<void> getCity(int cityId) =>
      (select(cityLocalModels)..where((tbl) => tbl.id.equals(cityId)))
          .getSingle();
}
