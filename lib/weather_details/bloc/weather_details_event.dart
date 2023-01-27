import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:klep_weather/weather/entity/weather_entity.dart';

@immutable
abstract class WeatherDetailsEvent extends Equatable {}

class WeatherChangedEvent extends WeatherDetailsEvent {
  WeatherChangedEvent({required this.weatherEntity});

  final WeatherEntity weatherEntity;

  @override
  List<Object> get props => [weatherEntity];
}

class WeatherLoadEvent extends WeatherDetailsEvent {
  WeatherLoadEvent({required this.cityId});

  final int cityId;

  @override
  List<Object> get props => [cityId];
}

class WeatherSubscribeEvent extends WeatherDetailsEvent {
  @override
  List<Object> get props => [];
}
