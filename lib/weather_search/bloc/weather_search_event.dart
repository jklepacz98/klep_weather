part of 'weather_search_bloc.dart';

@immutable
abstract class WeatherSearchEvent {}

class WeatherLoadEvent extends WeatherSearchEvent {
  final String city;

  WeatherLoadEvent({required this.city});

  @override
  List<Object> get props => [city];
}
