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
        coordLon: coord.lon,
        coordLat: coord.lat,
        //todo
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
        sysType: sys.type,
        sysId: sys.id,
        sysCountry: sys.country,
        sysSunrise: sys.sunrise,
        sysSunset: sys.sunset,
        timezone: timezone,
        id: id,
        name: name,
        cod: 200,
      );

//todo remove this function?
// factory WeatherModel.fromWeather(Weather weather) {
//   final wind = Wind(speed: 0, deg: 0);
//   return WeatherModel(id: weather.id, name: weather.name ?? "", wind: wind);
// }
}
