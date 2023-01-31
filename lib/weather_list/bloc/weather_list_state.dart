part of 'weather_list_bloc.dart';

enum WeatherListStatus { initial, loading, success, failure }

@immutable
class WeatherListState extends Equatable {
  const WeatherListState({
    this.status = WeatherListStatus.initial,
    this.weathers = const [],
  });

  final WeatherListStatus status;
  final List<WeatherItem> weathers;

  WeatherListState copyWith({
    WeatherListStatus? status,
    List<WeatherItem>? weathers,
  }) =>
      WeatherListState(
        status: status ?? this.status,
        weathers: weathers ?? this.weathers,
      );

  @override
  List<Object> get props => [status, weathers];
}
