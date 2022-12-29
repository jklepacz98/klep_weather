import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

//todo changename
@JsonSerializable()
@DataClassName("Weather")
class Weathers extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

  RealColumn get windSpeed => real().nullable()();

  IntColumn get windDeg => integer().nullable()();

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
    return into(weathers).insertOnConflictUpdate(weather);
  }

  Future<List<Weather>> getWeather() async {
    return select(weathers).get();
  }
}
