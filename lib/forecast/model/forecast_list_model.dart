import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as json_annotation;
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/model/city_model.dart';
import 'package:klep_weather/forecast/model/forecast_model.dart';

part 'forecast_list_model.g.dart';

@json_annotation.JsonSerializable()
class ForecastListModel {
  ForecastListModel({
    required this.forecastList,
    required this.city,
  });

  @json_annotation.JsonKey(name: 'list')
  final List<ForecastModel> forecastList;
  @json_annotation.JsonKey(name: 'city')
  final CityModel city;

  factory ForecastListModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListModelToJson(this);

  List<ForecastCompanion> toForecastCompanions() => forecastList
      .map(
        (forecast) => ForecastCompanion(
          cityId: Value(city.id),
          mainInfoTemp: Value(forecast.mainInfo.temp),
          mainInfoFeelsLike: Value(forecast.mainInfo.feelsLike),
          mainInfoTempMin: Value(forecast.mainInfo.tempMin),
          mainInfoTempMax: Value(forecast.mainInfo.tempMax),
          mainInfoPressure: Value(forecast.mainInfo.pressure),
          mainInfoHumidity: Value(forecast.mainInfo.humidity),
          weatherInfoId: Value(forecast.weatherInfo.first.id),
          weatherInfoMain: Value(forecast.weatherInfo.first.main),
          weatherInfoDescription: Value(forecast.weatherInfo.first.description),
          weatherInfoIcon: Value(forecast.weatherInfo.first.icon),
          cloudsAll: Value(forecast.clouds.all),
          windSpeed: Value(forecast.wind.speed),
          windDeg: Value(forecast.wind.deg),
          visibility: Value(forecast.visibility),
          dt: Value(forecast.dt),
        ),
      )
      .toList();
}
