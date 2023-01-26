import 'package:json_annotation/json_annotation.dart';

part 'weather_info_remote_model.g.dart';

@JsonSerializable()
class WeatherInfoRemoteModel {
  WeatherInfoRemoteModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory WeatherInfoRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoRemoteModelToJson(this);
}
