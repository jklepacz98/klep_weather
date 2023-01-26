part of 'forecast_list_bloc.dart';

//todo
enum ForecastListStatus { initial, loading, success, failure }

class ForecastListState extends Equatable {
  const ForecastListState({
    this.status = ForecastListStatus.initial,
    this.forecastList,
  });

  final ForecastListStatus status;
  final List<ForecastEntity>? forecastList;

  ForecastListState copyWith({
    ForecastListStatus? status,
    List<ForecastEntity>? forecastList,
  }) =>
      ForecastListState(
        status: status ?? this.status,
        forecastList: forecastList ?? this.forecastList,
      );

  @override
  List<Object?> get props => [status, forecastList];
}
