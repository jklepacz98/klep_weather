import 'package:drift/drift.dart';
import 'package:klep_weather/city_forecast/repository/forecast_remote_model.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/temperature.dart';

class ForecastEntity {
  const ForecastEntity(
      {required this.cityId,
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

  ForecastLocalModelsCompanion toForecastLocalModelsCompanion() =>
      ForecastLocalModelsCompanion(
        cityId: Value(cityId),
        mainInfoTemp: Value(mainInfoTemp.kelvin),
        mainInfoFeelsLike: Value(mainInfoFeelsLike.kelvin),
        mainInfoTempMin: Value(mainInfoTempMin.kelvin),
        mainInfoTempMax: Value(mainInfoTempMax.kelvin),
        mainInfoPressure: Value(mainInfoPressure),
        mainInfoHumidity: Value(mainInfoHumidity),
        weatherInfoId: Value(weatherInfoId),
        weatherInfoMain: Value(weatherInfoMain),
        weatherInfoDescription: Value(weatherInfoDescription),
        weatherInfoIcon: Value(weatherInfoIcon),
        cloudsAll: Value(cloudsAll),
        windSpeed: Value(windSpeed),
        windDeg: Value(windDeg),
        visibility: Value(visibility),
        dt: Value(dt),
      );

  factory ForecastEntity.fromForecastLocalModel(
          ForecastLocalModel forecastLocalModel) =>
      ForecastEntity(
        cityId: forecastLocalModel.cityId,
        mainInfoTemp: Temperature(kelvin: forecastLocalModel.mainInfoTemp),
        mainInfoFeelsLike:
            Temperature(kelvin: forecastLocalModel.mainInfoFeelsLike),
        mainInfoTempMin:
            Temperature(kelvin: forecastLocalModel.mainInfoTempMin),
        mainInfoTempMax:
            Temperature(kelvin: forecastLocalModel.mainInfoTempMax),
        mainInfoPressure: forecastLocalModel.mainInfoPressure,
        mainInfoHumidity: forecastLocalModel.mainInfoHumidity,
        weatherInfoId: forecastLocalModel.weatherInfoId,
        weatherInfoMain: forecastLocalModel.weatherInfoMain,
        weatherInfoDescription: forecastLocalModel.weatherInfoDescription,
        weatherInfoIcon: forecastLocalModel.weatherInfoIcon,
        cloudsAll: forecastLocalModel.cloudsAll,
        windSpeed: forecastLocalModel.windSpeed,
        windDeg: forecastLocalModel.windDeg,
        visibility: forecastLocalModel.visibility,
        dt: forecastLocalModel.dt,
      );

  factory ForecastEntity.fromForecastRemoteModel(
    int cityId,
    ForecastRemoteModel forecastRemoteModel,
  ) =>
      ForecastEntity(
        cityId: cityId,
        mainInfoTemp: Temperature(kelvin: forecastRemoteModel.mainInfo.temp),
        mainInfoFeelsLike:
            Temperature(kelvin: forecastRemoteModel.mainInfo.feelsLike),
        mainInfoTempMin:
            Temperature(kelvin: forecastRemoteModel.mainInfo.tempMin),
        mainInfoTempMax:
            Temperature(kelvin: forecastRemoteModel.mainInfo.tempMax),
        mainInfoPressure: forecastRemoteModel.mainInfo.pressure,
        mainInfoHumidity: forecastRemoteModel.mainInfo.humidity,
        weatherInfoId: forecastRemoteModel.weatherInfo.first.id,
        weatherInfoMain: forecastRemoteModel.weatherInfo.first.main,
        weatherInfoDescription:
            forecastRemoteModel.weatherInfo.first.description,
        weatherInfoIcon: forecastRemoteModel.weatherInfo.first.icon,
        cloudsAll: forecastRemoteModel.clouds.all,
        windSpeed: forecastRemoteModel.wind.speed,
        windDeg: forecastRemoteModel.wind.deg,
        visibility: forecastRemoteModel.visibility,
        dt: forecastRemoteModel.dt,
      );
}
