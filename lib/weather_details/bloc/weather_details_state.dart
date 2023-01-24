import 'dart:core';

import 'package:equatable/equatable.dart';

import '../../database/database.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

class WeatherDetailsState extends Equatable {
  const WeatherDetailsState(
      {this.status = WeatherStatus.initial, this.weather, this.forecastList});

  final WeatherStatus status;
  final Weather? weather;
  final List<Forecast>? forecastList;

  WeatherDetailsState copyWith({
    WeatherStatus? status,
    Weather? weather,
    List<Forecast>? forecastList,
  }) {
    return WeatherDetailsState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      forecastList: forecastList ?? this.forecastList,
    );
  }

//todo where should this method be
  static double? toCelsius(double? kelwinTemperature) {
    if (kelwinTemperature != null) {
      return kelwinTemperature - absoluteZero;
    } else {
      return null;
    }
  }

  static double absoluteZero = 273.15;

  @override
  List<Object?> get props => [status, weather, forecastList];
}
