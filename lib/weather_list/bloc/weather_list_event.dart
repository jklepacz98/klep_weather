part of 'weather_list_bloc.dart';

@immutable
abstract class WeatherListEvent extends Equatable {}

class WeatherListSubscribeEvent extends WeatherListEvent {
  @override
  List<Object> get props => [];
}

class WeatherListChangedEvent extends WeatherListEvent {
  final List<WeatherEntity> weatherList;

  WeatherListChangedEvent({required this.weatherList});

  @override
  List<Object> get props => [weatherList];
}

class WeatherListLoadEvent extends WeatherListEvent {
  @override
  List<Object> get props => [];
}