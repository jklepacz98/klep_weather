import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/weather/model/clouds.dart';
import 'package:klep_weather/weather/model/main_info.dart';

import '../../weather/model/weather_info.dart';
import '../../weather/model/wind.dart';

part 'forecast_item.g.dart';

@JsonSerializable()
class ForecastItem {
  ForecastItem({
    required this.dt,
    required this.mainInfo,
    required this.weatherInfo,
    required this.clouds,
    required this.wind,
    required this.visibility,
  });

  int dt;
  @JsonKey(name: "main")
  MainInfo mainInfo;
  @JsonKey(name: "weather")
  List<WeatherInfo> weatherInfo;
  Clouds clouds;
  Wind wind;
  int visibility;

  factory ForecastItem.fromJson(Map<String, dynamic> json) =>
      _$ForecastItemFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastItemToJson(this);
}
