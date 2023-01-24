part of 'weather_search_bloc.dart';

enum WeatherSearchStatus { initial, loading, success, failure }

class WeatherSearchState extends Equatable {
  const WeatherSearchState({this.status = WeatherSearchStatus.initial});

  final WeatherSearchStatus status;

  WeatherSearchState copyWith({WeatherSearchStatus? status}) =>
      WeatherSearchState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
