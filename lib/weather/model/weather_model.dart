import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/weather/model/wind.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  int id;
  String name;
  Wind wind;

  WeatherModel({
    required this.id,
    required this.name,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  Weather toWeather() => Weather(
        id: id,
        name: name,
        windSpeed: wind.speed,
        windDeg: wind.deg,
      );

  //todo
  factory WeatherModel.fromWeather(Weather weather) {
    final wind = Wind(speed: 0, deg: 0);
    return WeatherModel(id: weather.id, name: weather.name ?? "", wind: wind);
  }
}
