import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/forecast/model/city.dart';
import 'package:klep_weather/forecast/model/forecast_item.dart';


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


}
