import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/weather/model/clouds.dart';
import 'package:klep_weather/weather/model/main_info.dart';
import 'package:klep_weather/weather/model/sys.dart';
import 'package:klep_weather/weather/model/weather_info.dart';
import 'package:klep_weather/weather/model/wind.dart';

import 'coord.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weatherInfo,
    required this.base,
    required this.mainInfo,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  Coord coord;
  @JsonKey(name: "weather")
  List<WeatherInfo> weatherInfo;
  String base;
  @JsonKey(name: "main")
  MainInfo mainInfo;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  Weather toWeather() => Weather(
        id: id,
        name: name,
        windSpeed: wind.speed,
        windDeg: wind.deg,
      );

//todo remove this function?
// factory WeatherModel.fromWeather(Weather weather) {
//   final wind = Wind(speed: 0, deg: 0);
//   return WeatherModel(id: weather.id, name: weather.name ?? "", wind: wind);
// }
}
