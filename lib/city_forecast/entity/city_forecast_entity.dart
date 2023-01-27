import 'package:klep_weather/city/entity/city_entity.dart';
import 'package:klep_weather/city_forecast/model/city_forecast_list_remote_model.dart';
import 'package:klep_weather/forecast/entity/forecast_entity.dart';

import '../../utils/temperature.dart';

class CityForecastEntity {
  const CityForecastEntity({
    required this.forecastEntityList,
    required this.cityEntity,
  });

  final List<ForecastEntity> forecastEntityList;
  final CityEntity cityEntity;

  factory CityForecastEntity.fromCityForecastRemoteModel(
      CityForecastRemoteModel forecastListRemoteModel) {
    final cityRemoteModel = forecastListRemoteModel.city;
    return CityForecastEntity(
      cityEntity: CityEntity(
        id: cityRemoteModel.id,
        name: cityRemoteModel.name,
      ),
      forecastEntityList: forecastListRemoteModel.forecastList
          .map(
            (remoteModel) => ForecastEntity(
              cityId: forecastListRemoteModel.city.id,
              mainInfoTemp: Temperature(kelvin: remoteModel.mainInfo.temp),
              mainInfoFeelsLike:
                  Temperature(kelvin: remoteModel.mainInfo.feelsLike),
              mainInfoTempMin:
                  Temperature(kelvin: remoteModel.mainInfo.tempMin),
              mainInfoTempMax:
                  Temperature(kelvin: remoteModel.mainInfo.tempMax),
              mainInfoPressure: remoteModel.mainInfo.pressure,
              mainInfoHumidity: remoteModel.mainInfo.humidity,
              weatherInfoId: remoteModel.weatherInfo.first.id,
              weatherInfoMain: remoteModel.weatherInfo.first.main,
              weatherInfoDescription: remoteModel.weatherInfo.first.description,
              weatherInfoIcon: remoteModel.weatherInfo.first.icon,
              cloudsAll: remoteModel.clouds.all,
              windSpeed: remoteModel.wind.speed,
              windDeg: remoteModel.wind.deg,
              visibility: remoteModel.visibility,
              dt: remoteModel.dt,
            ),
          )
          .toList(),
    );
  }
}
