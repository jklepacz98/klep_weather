part of 'weather_list_bloc.dart';

enum WeatherListStatus { initial, loading, success, failure }

@immutable
class WeatherListState extends Equatable {
  const WeatherListState({
    this.status = WeatherListStatus.initial,
    this.weathers = const [],
  });

  final WeatherListStatus status;
  final List<Weather> weathers;

  WeatherListState copyWith({
    WeatherListStatus? status,
    List<Weather>? weathers,
  }) =>
      WeatherListState(
        status: status ?? this.status,
        weathers: weathers ?? this.weathers,
      );

  @override
  List<Object> get props => [status, weathers];
}
