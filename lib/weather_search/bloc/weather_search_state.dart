part of 'weather_search_bloc.dart';

enum WeatherSearchStatus { initial, loading, success, failure }

@freezed
class WeatherSearchState with _$WeatherSearchState {
  factory WeatherSearchState({
    required WeatherSearchStatus status,
  }) = _WeatherSearchState;
}
