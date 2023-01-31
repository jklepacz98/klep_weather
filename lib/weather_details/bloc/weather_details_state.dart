import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

class WeatherDetailsState extends Equatable {
  const WeatherDetailsState({
    this.status = WeatherStatus.initial,
    this.weatherItem,
  });

  final WeatherStatus status;
  final WeatherItem? weatherItem;

  WeatherDetailsState copyWith({
    WeatherStatus? status,
    WeatherItem? weatherItem,
    List<Forecast>? forecastList,
  }) =>
      WeatherDetailsState(
        status: status ?? this.status,
        weatherItem: weatherItem ?? this.weatherItem,
      );

  @override
  List<Object?> get props => [status, weatherItem];
}
