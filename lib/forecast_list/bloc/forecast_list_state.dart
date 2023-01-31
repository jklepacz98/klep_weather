part of 'forecast_list_bloc.dart';

//todo
enum ForecastListStatus { initial, loading, success, failure }

class ForecastListState extends Equatable {
  const ForecastListState({
    this.status = ForecastListStatus.initial,
    this.forecastItemList,
  });

  final ForecastListStatus status;
  final List<ForecastItem>? forecastItemList;

  ForecastListState copyWith({
    ForecastListStatus? status,
    List<ForecastItem>? forecastItemList,
  }) =>
      ForecastListState(
        status: status ?? this.status,
        forecastItemList: forecastItemList ?? this.forecastItemList,
      );

  @override
  List<Object?> get props => [status, forecastItemList];
}
