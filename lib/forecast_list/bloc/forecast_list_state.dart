part of 'forecast_list_bloc.dart';

//todo
enum ForecastListStatus { initial, loading, success, failure }

@freezed
class ForecastListState with _$ForecastListState {
  factory ForecastListState({
    @Default(ForecastListStatus.initial) ForecastListStatus status,
    @Default([]) List<ForecastItem> forecastItemList,
  }) = _ForecastListState;
}
