import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/database.dart';

@immutable
abstract class WeatherEvent extends Equatable {}

//todo
class WeatherValueChanged extends WeatherEvent {
  //todo Why I can't use const?
  WeatherValueChanged(this.city);

  final String city;

  @override
  List<Object> get props => [city];
}

class WeatherLoad extends WeatherEvent {
  final String city;

  //todo Why I can't use const?
  WeatherLoad({required this.city});

  @override
  List<Object> get props => [city];
}

class WeatherGet extends WeatherEvent {
  @override
  List<Object> get props => [];
}

//todo change name
class WeatherListChanged extends WeatherEvent {
  final List<Weather> weathers;

  WeatherListChanged({required this.weathers});

  @override
  List<Object> get props => [weathers];
}
