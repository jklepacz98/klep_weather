part of '../../forecast_list/bloc/forecast_list_bloc.dart';

@freezed
class ForecastListEvent with _$ForecastListEvent {
  const factory ForecastListEvent.forecastListChanged({
    required List<Forecast> forecastList,
  }) = ForecastListChangedEvent;

  const factory ForecastListEvent.forecastListLoad({
    required int cityId,
  }) = ForecastListLoadEvent;

  const factory ForecastListEvent.forecastListSubscribe() =
      ForecastListSubscribeEvent;
}
