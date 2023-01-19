import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/forecast/model/city.dart';
import 'package:klep_weather/forecast/model/forecast_item.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  ForecastModel({
    required this.forecastList,
    required this.city,
  });

  @JsonKey(name: 'list')
  final List<ForecastItem> forecastList;
  @JsonKey(name: 'city')
  final City city;

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
