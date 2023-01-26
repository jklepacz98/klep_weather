import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/weather/model/clouds_remote_model.dart';
import 'package:klep_weather/weather/model/main_info_remote_model.dart';

import '../../weather/model/weather_info_remote_model.dart';
import '../../weather/model/wind_remote_model.dart';

part 'forecast_remote_model.g.dart';

@JsonSerializable()
class ForecastRemoteModel {
  ForecastRemoteModel({
    required this.dt,
    required this.mainInfo,
    required this.weatherInfo,
    required this.clouds,
    required this.wind,
    required this.visibility,
  });

  int dt;
  @JsonKey(name: "main")
  MainInfoRemoteModel mainInfo;
  @JsonKey(name: "weather")
  List<WeatherInfoRemoteModel> weatherInfo;
  CloudsRemoteModel clouds;
  WindRemoteModel wind;
  int visibility;

  factory ForecastRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastRemoteModelToJson(this);
}
