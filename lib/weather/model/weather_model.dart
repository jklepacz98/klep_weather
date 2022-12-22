import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherModel {
  String id;
  String value;

  WeatherModel({this.id, this.value})
}