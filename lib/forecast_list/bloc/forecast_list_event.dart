part of '../../forecast_list/bloc/forecast_list_bloc.dart';

@immutable
abstract class ForecastListEvent {}

class ForecastListChangedEvent extends ForecastListEvent {
  final List<Forecast> forecastList;

  ForecastListChangedEvent({required this.forecastList});

  @override
  List<Object> get props => [forecastList];
}

class ForecastListLoadEvent extends ForecastListEvent {
  final int cityId;

  ForecastListLoadEvent({required this.cityId});

  @override
  List<Object> get props => [cityId];
}

class ForecastListSubscribeEvent extends ForecastListEvent {
  @override
  List<Object> get props => [];
}
