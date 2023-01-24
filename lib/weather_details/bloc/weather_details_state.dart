import 'dart:core';

import 'package:equatable/equatable.dart';

import '../../database/database.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

class WeatherDetailsState extends Equatable {
  const WeatherDetailsState(
      {this.status = WeatherStatus.initial, this.weather});

  final WeatherStatus status;
  final Weather? weather;

  WeatherDetailsState copyWith({
    WeatherStatus? status,
    Weather? weather,
    List<Forecast>? forecastList,
  }) =>
      WeatherDetailsState(
        status: status ?? this.status,
        weather: weather ?? this.weather,
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
  List<Object?> get props => [status, weather];
}
