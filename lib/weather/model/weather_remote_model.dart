import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/weather/model/clouds_remote_model.dart';
import 'package:klep_weather/weather/model/main_info_remote_model.dart';
import 'package:klep_weather/weather/model/weather_info_remote_model.dart';
import 'package:klep_weather/weather/model/wind_remote_model.dart';

import 'coord_remote_model.dart';

part 'weather_remote_model.g.dart';

@JsonSerializable()
class WeatherRemoteModel {
  WeatherRemoteModel({
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

  CoordRemoteModel coord;
  @JsonKey(name: "weather")
  List<WeatherInfoRemoteModel> weatherInfo;

  //todo
  // String base;
  @JsonKey(name: "main")
  MainInfoRemoteModel mainInfo;
  int visibility;
  WindRemoteModel wind;
  CloudsRemoteModel clouds;
  int dt;
  int id;
  String name;

  factory WeatherRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRemoteModelToJson(this);
}
