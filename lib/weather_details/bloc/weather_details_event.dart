import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:klep_weather/database/database.dart';

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
