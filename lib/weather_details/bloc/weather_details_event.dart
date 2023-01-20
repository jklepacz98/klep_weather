import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../database/database.dart';

@immutable
abstract class WeatherDetailsEvent extends Equatable {}

class WeatherChangedEvent extends WeatherDetailsEvent {
  final Weather weather;

  WeatherChangedEvent({required this.weather});

  @override
  List<Object> get props => [weather];
}

class WeatherLoadEvent extends WeatherDetailsEvent {
  final int cityId;

  WeatherLoadEvent({required this.cityId});

  @override
  List<Object> get props => [cityId];
}

class WeatherSubscribeEvent extends WeatherDetailsEvent {
  @override
  List<Object> get props => [];
}

//todo change to ForecastListChangedEvent ?
class ForecastChangedEvent extends WeatherDetailsEvent {
  final List<Forecast> forecastList;

  ForecastChangedEvent({required this.forecastList});

  @override
  List<Object> get props => [forecastList];
}

class ForecastLoadEvent extends WeatherDetailsEvent {
  final int cityId;

  ForecastLoadEvent({required this.cityId});

  @override
  List<Object> get props => [cityId];
}

class ForecastSubscribeEvent extends WeatherDetailsEvent {
  @override
  List<Object> get props => [];
}
