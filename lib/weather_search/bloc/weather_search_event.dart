part of 'weather_search_bloc.dart';

@freezed
class WeatherSearchEvent with _$WeatherSearchEvent {
  const factory WeatherSearchEvent.weatherLoad({required String city}) =
      WeatherLoadEvent;
}
