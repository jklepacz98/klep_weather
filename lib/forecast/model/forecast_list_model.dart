import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/forecast/model/city_model.dart';
import 'package:klep_weather/forecast/model/forecast_model.dart';

part 'forecast_list_model.g.dart';

@JsonSerializable()
class ForecastListModel {
  ForecastListModel({
    required this.forecastList,
    required this.city,
  });

  @JsonKey(name: 'list')
  final List<ForecastModel> forecastList;
  @JsonKey(name: 'city')
  final CityModel city;

  factory ForecastListModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListModelToJson(this);

// ForecastModel toForecast() => Forecast()
}
