import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/weather/model/weather_remote_model.dart';

part 'weather_group_remote_model.g.dart';

@JsonSerializable()
class WeatherGroupRemoteModel {
  WeatherGroupRemoteModel({
    required this.count,
    required this.weatherList,
  });

  @JsonKey(name: 'cnt')
  int count;
  @JsonKey(name: 'list')
  List<WeatherRemoteModel> weatherList;

  factory WeatherGroupRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherGroupRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherGroupRemoteModelToJson(this);
}
