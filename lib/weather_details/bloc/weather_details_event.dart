part of 'weather_details_bloc.dart';

@freezed
class WeatherDetailsEvent with _$WeatherDetailsEvent {
  factory WeatherDetailsEvent.weatherChanged({required Weather weather}) =
      WeatherChangedEvent;

  factory WeatherDetailsEvent.weatherLoad({required int cityId}) =
      WeatherLoadEvent;

  factory WeatherDetailsEvent.weatherSubscribe() = WeatherSubscribeEvent;
}
