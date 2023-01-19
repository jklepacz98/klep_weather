import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('Weather')
class WeatherTable extends Table {
  RealColumn get coordLon => real().nullable()();

  RealColumn get coordLat => real().nullable()();

  IntColumn get weatherInfoId => integer().nullable()();

  TextColumn get weatherInfoMain => text().nullable()();

  TextColumn get weatherInfoDescription => text().nullable()();

  TextColumn get weatherInfoIcon => text().nullable()();

  RealColumn get mainInfoTemp => real().nullable()();

  RealColumn get mainInfoFeelsLike => real().nullable()();

  RealColumn get mainInfoTempMin => real().nullable()();

  RealColumn get mainInfoTempMax => real().nullable()();

  IntColumn get mainInfoPressure => integer().nullable()();

  IntColumn get mainInfoHumidity => integer().nullable()();

  IntColumn get visibility => integer().nullable()();

  RealColumn get windSpeed => real().nullable()();

  IntColumn get windDeg => integer().nullable()();

  IntColumn get cloudsAll => integer().nullable()();

  IntColumn get dt => integer().nullable()();

  IntColumn get sysType => integer().nullable()();

  IntColumn get sysId => integer().nullable()();

  TextColumn get sysCountry => text().nullable()();

  IntColumn get sysSunrise => integer().nullable()();

  IntColumn get sysSunset => integer().nullable()();

  IntColumn get timezone => integer().nullable()();

  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

  IntColumn get cod => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Forecast')
class ForecastTable extends Table {
  IntColumn get cityId => integer().nullable()();

  IntColumn get weatherInfoId => integer().nullable()();

  TextColumn get weatherInfoMain => text().nullable()();

  TextColumn get weatherInfoDescription => text().nullable()();

  TextColumn get weatherInfoIcon => text().nullable()();

  RealColumn get mainInfoTemp => real().nullable()();

  RealColumn get mainInfoFeelsLike => real().nullable()();

  RealColumn get mainInfoTempMin => real().nullable()();

  RealColumn get mainInfoTempMax => real().nullable()();

  IntColumn get mainInfoPressure => integer().nullable()();

  IntColumn get mainInfoHumidity => integer().nullable()();

  IntColumn get visibility => integer().nullable()();

  RealColumn get windSpeed => real().nullable()();

  IntColumn get windDeg => integer().nullable()();

  IntColumn get cloudsAll => integer().nullable()();

  IntColumn get dt => integer().nullable()();

  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('City')
class CityTable extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

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
      (select(weatherTable)
        ..where((tbl) => tbl.id.equals(id))).watchSingle();

  Stream<List<Weather>> observeWeathers() => select(weatherTable).watch();

  //todo not used
  Future<Weather> getWeather(int id) =>
      (select(weatherTable)
        ..where((tbl) => tbl.id.equals(id))).getSingle();

  //todo not used
  Future<List<Weather>> getWeathers() => select(weatherTable).get();

  Future<void> addForecasts(List<Forecast> forecast) async {

  }
}
