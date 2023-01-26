import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/Temperature.dart';
import 'package:klep_weather/weather/model/weather_remote_model.dart';

class WeatherEntity {
  const WeatherEntity._(
      {required this.coordLon,
      required this.coordLat,
      required this.weatherInfoId,
      required this.weatherInfoMain,
      required this.weatherInfoDescription,
      required this.weatherInfoIcon,
      required this.mainInfoTemp,
      required this.mainInfoFeelsLike,
      required this.mainInfoTempMin,
      required this.mainInfoTempMax,
      required this.mainInfoPressure,
      required this.mainInfoHumidity,
      required this.visibility,
      required this.windSpeed,
      required this.windDeg,
      required this.cloudsAll,
      required this.dt,
      required this.id,
      required this.name});

  final double coordLon;
  final double coordLat;
  final int weatherInfoId;
  final String weatherInfoMain;
  final String weatherInfoDescription;
  final String weatherInfoIcon;
  final Temperature mainInfoTemp;
  final Temperature mainInfoFeelsLike;
  final Temperature mainInfoTempMin;
  final Temperature mainInfoTempMax;
  final int mainInfoPressure;
  final int mainInfoHumidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final int cloudsAll;
  final int dt;
  final int id;
  final String name;

  factory WeatherEntity.fromWeatherRemoteModel(
          WeatherRemoteModel remoteModel) =>
      WeatherEntity._(
        coordLon: remoteModel.coord.lon,
        coordLat: remoteModel.coord.lat,
        weatherInfoId: remoteModel.weatherInfo.first.id,
        weatherInfoMain: remoteModel.weatherInfo.first.main,
        weatherInfoDescription: remoteModel.weatherInfo.first.description,
        weatherInfoIcon: remoteModel.weatherInfo.first.icon,
        mainInfoTemp: Temperature(kelvin: remoteModel.mainInfo.temp),
        mainInfoFeelsLike: Temperature(kelvin: remoteModel.mainInfo.feelsLike),
        mainInfoTempMin: Temperature(kelvin: remoteModel.mainInfo.tempMin),
        mainInfoTempMax: Temperature(kelvin: remoteModel.mainInfo.tempMax),
        mainInfoPressure: remoteModel.mainInfo.pressure,
        mainInfoHumidity: remoteModel.mainInfo.humidity,
        visibility: remoteModel.visibility,
        windSpeed: remoteModel.wind.speed,
        windDeg: remoteModel.wind.deg,
        cloudsAll: remoteModel.clouds.all,
        dt: remoteModel.dt,
        id: remoteModel.id,
        name: remoteModel.name,
      );

  WeatherLocalModel toWeatherLocalModel() => WeatherLocalModel(
        coordLon: coordLon,
        coordLat: coordLat,
        weatherInfoId: weatherInfoId,
        weatherInfoMain: weatherInfoMain,
        weatherInfoDescription: weatherInfoDescription,
        weatherInfoIcon: weatherInfoIcon,
        mainInfoTemp: mainInfoTemp.kelvin,
        mainInfoFeelsLike: mainInfoFeelsLike.kelvin,
        mainInfoTempMin: mainInfoTempMin.kelvin,
        mainInfoTempMax: mainInfoTempMax.kelvin,
        mainInfoPressure: mainInfoPressure,
        mainInfoHumidity: mainInfoHumidity,
        visibility: visibility,
        windSpeed: windSpeed,
        windDeg: windDeg,
        cloudsAll: cloudsAll,
        dt: dt,
        id: id,
        name: name,
      );

  factory WeatherEntity.fromWeatherLocalModel(WeatherLocalModel localModel) =>
      WeatherEntity._(
        coordLon: localModel.coordLon,
        coordLat: localModel.coordLat,
        weatherInfoId: localModel.weatherInfoId,
        weatherInfoMain: localModel.weatherInfoMain,
        weatherInfoDescription: localModel.weatherInfoDescription,
        weatherInfoIcon: localModel.weatherInfoIcon,
        mainInfoTemp: Temperature(kelvin: localModel.mainInfoTemp),
        mainInfoFeelsLike: Temperature(kelvin: localModel.mainInfoFeelsLike),
        mainInfoTempMin: Temperature(kelvin: localModel.mainInfoTempMin),
        mainInfoTempMax: Temperature(kelvin: localModel.mainInfoTempMax),
        mainInfoPressure: localModel.mainInfoPressure,
        mainInfoHumidity: localModel.mainInfoHumidity,
        visibility: localModel.visibility,
        windSpeed: localModel.windSpeed,
        windDeg: localModel.windDeg,
        cloudsAll: localModel.cloudsAll,
        dt: localModel.dt,
        id: localModel.id,
        name: localModel.name,
      );
}
