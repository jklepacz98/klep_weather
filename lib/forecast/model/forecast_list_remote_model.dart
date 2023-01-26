import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as JsonAnnotation;
import 'package:klep_weather/forecast/model/city_remote_model.dart';
import 'package:klep_weather/forecast/model/forecast_remote_model.dart';

import '../../database/database.dart';

part 'forecast_list_remote_model.g.dart';

@JsonAnnotation.JsonSerializable()
class ForecastListRemoteModel {
  ForecastListRemoteModel({
    required this.forecastList,
    required this.city,
  });

  @JsonAnnotation.JsonKey(name: 'list')
  final List<ForecastRemoteModel> forecastList;
  @JsonAnnotation.JsonKey(name: 'city')
  final CityRemoteModel city;

  factory ForecastListRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastListRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListRemoteModelToJson(this);

  //todo remove
  List<ForecastLocalModelsCompanion> toForecastTableCompanions() => forecastList
      .map(
        (forecast) => ForecastLocalModelsCompanion(
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
