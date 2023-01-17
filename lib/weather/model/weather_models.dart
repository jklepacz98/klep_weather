import 'package:json_annotation/json_annotation.dart';
import 'package:klep_weather/weather/model/weather_model.dart';

part 'weather_models.g.dart';

@JsonSerializable()
class WeatherModels {
  WeatherModels({
    required this.count,
    required this.weatherList,
  });

  @JsonKey(name: 'cnt')
  int count;
  @JsonKey(name: 'list')
  List<WeatherModel> weatherList;

  factory WeatherModels.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelsToJson(this);
}
