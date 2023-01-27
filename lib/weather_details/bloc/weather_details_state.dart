import 'dart:core';

import 'package:equatable/equatable.dart';

import '../../forecast/entity/forecast_entity.dart';
import '../../weather/entity/weather_entity.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

class WeatherDetailsState extends Equatable {
  const WeatherDetailsState(
      {this.status = WeatherStatus.initial, this.weatherEntity});

  final WeatherStatus status;
  final WeatherEntity? weatherEntity;

  WeatherDetailsState copyWith({
    WeatherStatus? status,
    WeatherEntity? weatherEntity,
    List<ForecastEntity>? forecastList,
  }) =>
      WeatherDetailsState(
        status: status ?? this.status,
        weatherEntity: weatherEntity ?? this.weatherEntity,
      );

//todo where should this method be
  static double? toCelsius(double? kelwinTemperature) {
    if (kelwinTemperature != null) {
      return kelwinTemperature - absoluteZero;
    } else {
      return null;
    }
  }

  //todo also move this with method
  static double absoluteZero = 273.15;

  @override
  List<Object?> get props => [status, weatherEntity];
}
