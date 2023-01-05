import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class WeatherDetailsEvent extends Equatable {}

class WeatherLoadEvent extends WeatherDetailsEvent {
  @override
  List<Object> get props => [];
}

class WeatherSubscribeEvent extends WeatherDetailsEvent {
  @override
  List<Object> get props => [];
}
