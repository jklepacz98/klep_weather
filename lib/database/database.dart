import 'dart:io';

import 'package:drift/native.dart';
import 'package:klep_weather/weather/model/weather_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';

part 'database.g.dart';

//todo changename
@DataClassName("Weather")
class Weathers extends Table {
  TextColumn get id => text()();

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

@DriftDatabase(tables: [Weathers])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //todo do I need async here
  Future<int> addWeather(Weather weather) async {
    return into(weather).insertOnConflictUpdate(weather);
  }

  Future<List<Weather>?>getWeather() async {
    return select(weather).get();
  }
}
