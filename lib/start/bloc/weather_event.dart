import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/database.dart';

@immutable
abstract class WeatherEvent extends Equatable {}

class WeatherLoadEvent extends WeatherEvent {
  final String city;

  //todo Why I can't use const?
  WeatherLoadEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class WeatherGetEvent extends WeatherEvent {
  @override
  List<Object> get props => [];
}

//todo change name
class WeatherListChangedEvent extends WeatherEvent {
  final List<Weather> weathers;

  WeatherListChangedEvent({required this.weathers});

  @override
  List<Object> get props => [weathers];
}
