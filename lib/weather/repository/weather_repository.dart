import 'dart:async';

import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/weather/entity/weather_entity.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';

class WeatherRepository {
  WeatherRepository({
    required WeatherRemote weatherRemote,
    required WeatherLocal weatherLocal,
  })  : _weatherRemote = weatherRemote,
        _weatherLocal = weatherLocal;

  final WeatherRemote _weatherRemote;
  final WeatherLocal _weatherLocal;

  Future<Result<WeatherEntity>> loadWeatherByCity(String city) async {
    final remoteResult = await _weatherRemote.loadWeatherByCity(city);
    if (remoteResult.isSuccess) {
      final remoteModel = remoteResult.value!;
      final entity = WeatherEntity.fromWeatherRemoteModel(remoteModel);
      final localModel = entity.toWeatherLocalModel();
      await _weatherLocal.saveWeather(localModel);
      return Result.success(entity);
    } else {
      return Result.failure(remoteResult.failure!.reason);
    }
  }

  Future<Result<WeatherEntity>> loadWeatherById(int id) async {
    final remoteResult = await _weatherRemote.loadWeatherById(id);
    if (remoteResult.isSuccess) {
      final remoteModel = remoteResult.value!;
      final entity = WeatherEntity.fromWeatherRemoteModel(remoteModel);
      final localModel = entity.toWeatherLocalModel();
      await _weatherLocal.saveWeather(localModel);
      return Result.success(entity);
    } else {
      return Result.failure(remoteResult.failure!.reason);
    }
  }

  Future<Result<List<WeatherEntity>>> loadWeatherListByIds(
      List<int> ids) async {
    final remoteResult = await _weatherRemote.loadWeathersByIds(ids);
    if (remoteResult.isSuccess) {
      final remoteModelList = remoteResult.value!.weatherList;
      final entityList = remoteModelList
          .map((remoteModel) =>
              WeatherEntity.fromWeatherRemoteModel(remoteModel))
          .toList();
      final localModelList =
          entityList.map((entity) => entity.toWeatherLocalModel()).toList();
      await _weatherLocal.saveWeatherList(localModelList);
      return Result.success(entityList);
    } else {
      return Result.failure(remoteResult.failure!.reason);
    }
  }

  Stream<WeatherEntity> observeWeather(int id) => _weatherLocal
      .observeWeather(id)
      .map((localModel) => WeatherEntity.fromWeatherLocalModel(localModel));

  Stream<List<WeatherEntity>> observeWeatherList() =>
      //todo maybe extract to another function
      _weatherLocal.observeWeatherList().map(
            (localModelList) => localModelList
                .map(
                  (localModel) =>
                      WeatherEntity.fromWeatherLocalModel(localModel),
                )
                .toList(),
          );

  Future<WeatherEntity> getWeather(int id) async {
    final localModel = await _weatherLocal.getWeather(id);
    return WeatherEntity.fromWeatherLocalModel(localModel);
  }

  Future<List<WeatherEntity>> getWeatherList() async {
    final localModelList = await _weatherLocal.getWeatherList();
    return localModelList
        .map((localModel) => WeatherEntity.fromWeatherLocalModel(localModel))
        .toList();
  }
}
