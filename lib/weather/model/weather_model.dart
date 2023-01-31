import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/weather/model/clouds.dart';
import 'package:klep_weather/weather/model/main_info.dart';
import 'package:klep_weather/weather/model/weather_info.dart';
import 'package:klep_weather/weather/model/wind.dart';

import 'coord.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weatherInfo,
    required this.mainInfo,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.id,
    required this.name,
  });

  Coord coord;
  @JsonKey(name: 'weather')
  List<WeatherInfo> weatherInfo;

  //todo
  // String base;
  @JsonKey(name: 'main')
  MainInfo mainInfo;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  int id;
  String name;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  Weather toWeather() => Weather(
        coordLon: coord.lon,
        coordLat: coord.lat,
        //todo first
        weatherInfoId: weatherInfo.first.id,
        weatherInfoMain: weatherInfo.first.main,
        weatherInfoDescription: weatherInfo.first.description,
        weatherInfoIcon: weatherInfo.first.icon,
        mainInfoTemp: mainInfo.temp,
        mainInfoFeelsLike: mainInfo.feelsLike,
        mainInfoTempMin: mainInfo.tempMin,
        mainInfoTempMax: mainInfo.tempMax,
        mainInfoPressure: mainInfo.pressure,
        mainInfoHumidity: mainInfo.humidity,
        visibility: visibility,
        windSpeed: wind.speed,
        windDeg: wind.deg,
        cloudsAll: clouds.all,
        dt: dt,
        id: id,
        name: name,
      );
}
