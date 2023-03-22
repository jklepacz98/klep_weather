part of 'weather_details_bloc.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

@freezed
class WeatherDetailsState with _$WeatherDetailsState {
  const factory WeatherDetailsState({
    @Default(WeatherStatus.initial) WeatherStatus status,
    @Default(null) WeatherItem? weatherItem,
  }) = _WeatherDetailsState;
}
