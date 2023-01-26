import 'package:klep_weather/forecast/model/forecast_list_remote_model.dart';

import '../../utils/Temperature.dart';
import 'city_entity.dart';
import 'forecast_entity.dart';

class ForecastListEntity {
  const ForecastListEntity({
    required this.forecastListEntity,
    required this.cityEntity,
  });

  final List<ForecastEntity> forecastListEntity;
  final CityEntity cityEntity;

  factory ForecastListEntity.fromForecastListRemoteModel(
      ForecastListRemoteModel forecastListRemoteModel) {
    final cityRemoteModel = forecastListRemoteModel.city;
    return ForecastListEntity(
      //todo
      cityEntity: CityEntity(
        id: cityRemoteModel.id,
        name: cityRemoteModel.name,
      ),
      forecastListEntity: forecastListRemoteModel.forecastList
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
