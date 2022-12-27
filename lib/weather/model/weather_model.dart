import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/database/database.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  int id;
  String name;

  WeatherModel({
    required this.id,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  Weather toWeather() {
    return Weather(id: id, name: name);
  }
}
