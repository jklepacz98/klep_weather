import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_event.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

import '../../database/database.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherDetailsBloc(
      {required WeatherRepository weatherRepository, required int weatherId})
      : _weatherRepository = weatherRepository,
        _weatherId = weatherId,
  //todo contst
        super(const WeatherDetailsState(status: WeatherStatus.initial)) {
    on<WeatherSubscribeEvent>(_handleWeatherSubscribeEvent);
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
    add(WeatherSubscribeEvent());
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<Weather>? _weatherSubscription;

  //todo should this variable be here
  final int _weatherId;

  Future<void> _handleWeatherSubscribeEvent(WeatherSubscribeEvent event,
      Emitter emit,) async {
    _weatherSubscription = _weatherRepository.observeWeather(_weatherId).listen(
          (weather) {
        emit(state.copyWith(weather: weather));
      },
    );
  }

  Future<void> _handleWeatherLoadEvent(WeatherLoadEvent event,
      Emitter emit,) async {

  }
}
