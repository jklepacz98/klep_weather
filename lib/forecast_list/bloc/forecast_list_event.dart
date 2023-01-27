part of '../../forecast_list/bloc/forecast_list_bloc.dart';

@immutable
abstract class ForecastListEvent {}

class ForecastListChangedEvent extends ForecastListEvent {
  ForecastListChangedEvent({required this.forecastList});

  final List<ForecastEntity> forecastList;

  @override
  List<Object> get props => [forecastList];
}

class ForecastListLoadEvent extends ForecastListEvent {
  ForecastListLoadEvent({required this.cityId});

  final int cityId;

  @override
  List<Object> get props => [cityId];
}

class ForecastListSubscribeEvent extends ForecastListEvent {
  @override
  List<Object> get props => [];
}
