part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

//todo
class WeatherValueChanged extends WeatherEvent {
  //todo Why I can't use const?
  WeatherValueChanged(this.city);

  final String city;
}

class WeatherGet extends WeatherEvent {}
