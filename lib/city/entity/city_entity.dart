import 'package:klep_weather/database/database.dart';

class CityEntity {
  const CityEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  CityLocalModel toCityLocalModel() => CityLocalModel(id: id, name: name);
}
