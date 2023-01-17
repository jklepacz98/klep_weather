import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/database.dart';

@immutable
abstract class StartEvent extends Equatable {}

class WeatherLoadEvent extends StartEvent {
  final String city;

  //todo Why I can't use const?
  WeatherLoadEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class WeatherSubscribeEvent extends StartEvent {
  @override
  List<Object> get props => [];
}

class WeatherListChangedEvent extends StartEvent {
  @override
  final List<Weather> weathers;

  WeatherListChangedEvent({required this.weathers});

  @override
  List<Object> get props => [weathers];
}

class WeatherListLoadEvent extends StartEvent {
  @override
  List<Object> get props => [];
}
