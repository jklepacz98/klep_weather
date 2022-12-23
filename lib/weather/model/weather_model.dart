import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  String id;
  String name;

  WeatherModel({
    required this.id,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
