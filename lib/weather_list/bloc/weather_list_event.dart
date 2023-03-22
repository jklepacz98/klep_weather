part of 'weather_list_bloc.dart';

@freezed
class WeatherListEvent with _$WeatherListEvent {
  const factory WeatherListEvent.weatherListSubscribe() =
      WeatherListSubscribeEvent;

  const factory WeatherListEvent.weatherListChanged(
      {required List<Weather> weatherList}) = WeatherListChangedEvent;

  const factory WeatherListEvent.weatherListLoad() = WeatherListLoadEvent;

  const factory WeatherListEvent.weatherItemDelete({required int cityId}) =
      WeatherItemDeleteEvent;
}
