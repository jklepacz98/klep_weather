import 'package:isar/isar.dart';
import 'package:klep_weather/weather/model/weather_model.dart';

part 'weather_model_local.g.dart';

@collection
class WeatherModelLocal {
  Id id = Isar.autoIncrement;

  String name = "";

  WeatherModel toWeatherModel() => WeatherModel(id: id, name: name);
}
