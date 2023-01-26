import 'package:klep_weather/forecast/model/forecast_remote_model.dart';
import 'package:klep_weather/utils/Temperature.dart';

class ForecastEntity {
  const ForecastEntity._({required this.id,
    required this.cityId,
    required this.mainInfoTemp,
    required this.mainInfoFeelsLike,
    required this.mainInfoTempMin,
    required this.mainInfoTempMax,
    required this.mainInfoPressure,
    required this.mainInfoHumidity,
    required this.weatherInfoId,
    required this.weatherInfoMain,
    required this.weatherInfoDescription,
    required this.weatherInfoIcon,
    required this.cloudsAll,
    required this.windSpeed,
    required this.windDeg,
    required this.visibility,
    required this.dt});

  final int id;
  final int cityId;
  final Temperature mainInfoTemp;
  final Temperature mainInfoFeelsLike;
  final Temperature mainInfoTempMin;
  final Temperature mainInfoTempMax;
  final int mainInfoPressure;
  final int mainInfoHumidity;
  final int weatherInfoId;
  final String weatherInfoMain;
  final String weatherInfoDescription;
  final String weatherInfoIcon;
  final int cloudsAll;
  final double windSpeed;
  final int windDeg;
  final int visibility;
  final int dt;

  factory ForecastEntity.fromForecastRemoteModel(
      ForecastRemoteModel remoteModel, int cityId) =>
      ForecastEntity._(id: remoteModel.id,
          cityId: remoteModel.city.id,
          mainInfoTemp: remoteModel.mainInfoTemp,
          mainInfoFeelsLike: remoteModel.mainInfoFeelsLike,
          mainInfoTempMin: remoteModel.mainInfoTempMin,
          mainInfoTempMax: remoteModel.mainInfoTempMax,
          mainInfoPressure: remoteModel.mainInfoPressure,
          mainInfoHumidity: remoteModel.mainInfoHumidity,
          weatherInfoId: remoteModel.weatherInfoId,
          weatherInfoMain: remoteModel.weatherInfoMain,
          weatherInfoDescription: remoteModel.weatherInfoDescription,
          weatherInfoIcon: remoteModel.weatherInfoIcon,
          cloudsAll: remoteModel.cloudsAll,
          windSpeed: remoteModel.windSpeed,
          windDeg: remoteModel.windDeg,
          visibility: remoteModel.visibility,
          dt: remoteModel.dt)
}
