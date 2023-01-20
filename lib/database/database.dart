import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('Weather')
class WeatherTable extends Table {
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

@DataClassName('Forecast')
class ForecastTable extends Table {
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

//todo currently not using table
@DataClassName('City')
class CityTable extends Table {
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

@DriftDatabase(tables: [WeatherTable, ForecastTable, CityTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addWeather(Weather weather) =>
      into(weatherTable).insertOnConflictUpdate(weather);

  Future<void> addWeathers(List<Weather> weatherList) async {
    await batch(
      (batch) {
        batch.insertAllOnConflictUpdate(weatherTable, weatherList);
      },
    );
  }

  Stream<Weather> observeWeather(int id) =>
      (select(weatherTable)..where((tbl) => tbl.id.equals(id))).watchSingle();

  Stream<List<Weather>> observeWeathers() => select(weatherTable).watch();

  //todo not used
  Future<Weather> getWeather(int id) =>
      (select(weatherTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  //todo not used
  Future<List<Weather>> getWeathers() => select(weatherTable).get();

  Future<void> addForecasts(
      List<ForecastTableCompanion> forecastTableCompanionList) async {
    await batch(
      (batch) {
        batch.insertAllOnConflictUpdate(
            forecastTable, forecastTableCompanionList);
      },
    );
  }

  //todo by cityId???
  Stream<List<Forecast>> observeForecastsByCityId(int cityId) =>
      (select(forecastTable)..where((tbl) => tbl.cityId.equals(cityId)))
          .watch();

  Future<void> removeForecastsByCityId(int cityId) =>
      (delete(forecastTable)..where((tbl) => tbl.cityId.equals(cityId))).go();
}
