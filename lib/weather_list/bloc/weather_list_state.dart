part of 'weather_list_bloc.dart';

enum WeatherListStatus { initial, loading, success, failure }

@freezed
class WeatherListState with _$WeatherListState {
  const factory WeatherListState({
    @Default(WeatherListStatus.initial) WeatherListStatus status,
    @Default([]) List<WeatherItem> weathers,
  }) = _WeatherListState;
}
