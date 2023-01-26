import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/weather/model/weather_remote_model.dart';

part 'weather_list_remote_model.g.dart';

@JsonSerializable()
class WeatherListRemoteModel {
  WeatherListRemoteModel({
    required this.count,
    required this.weatherList,
  });

  @JsonKey(name: 'cnt')
  int count;
  @JsonKey(name: 'list')
  List<WeatherRemoteModel> weatherList;

  factory WeatherListRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherListRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherListRemoteModelToJson(this);
}
