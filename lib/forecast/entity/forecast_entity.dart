import 'package:drift/drift.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/Temperature.dart';

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
}
