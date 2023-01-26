import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../weather/entity/weather_entity.dart';

@immutable
abstract class WeatherDetailsEvent extends Equatable {}

class WeatherChangedEvent extends WeatherDetailsEvent {
  final WeatherEntity weatherEntity;

  WeatherChangedEvent({required this.weatherEntity});

  @override
  List<Object> get props => [weatherEntity];
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
