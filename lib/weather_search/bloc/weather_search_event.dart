part of 'weather_search_bloc.dart';

@immutable
abstract class WeatherSearchEvent extends Equatable {}

class WeatherLoadEvent extends WeatherSearchEvent {
  final String cityName;

  WeatherLoadEvent({required this.cityName});

  @override
  List<Object> get props => [cityName];
}

class SuggestionsEvent extends WeatherSearchEvent {
  final String cityName;

  SuggestionsEvent({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
