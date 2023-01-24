import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_event.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

import '../../database/database.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherDetailsBloc({
    required WeatherRepository weatherRepository,
    required int cityId,
  })  : _weatherRepository = weatherRepository,
        _cityId = cityId,
        super(const WeatherDetailsState(status: WeatherStatus.initial)) {
    _registerEventHandlers();
    _init();
  }

  void _registerEventHandlers() {
    on<WeatherChangedEvent>(_handleWeatherChangedEvent);
    on<WeatherSubscribeEvent>(_handleWeatherSubscribeEvent);
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
  }

  //todo think of a better name
  void _init() {
    add(WeatherSubscribeEvent());
    add(WeatherLoadEvent(cityId: _cityId));
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<Weather>? _weatherSubscription;

  //todo should this variable be here
  final int _cityId;

  _handleWeatherChangedEvent(
    WeatherChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(weather: event.weather));
  }

  _handleWeatherSubscribeEvent(
    WeatherSubscribeEvent event,
    Emitter emit,
  ) async {
    _weatherSubscription = _weatherRepository.observeWeather(_cityId).listen(
      (weather) {
        add(WeatherChangedEvent(weather: weather));
      },
    );
  }

  Future<void> _handleWeatherLoadEvent(
    WeatherLoadEvent event,
    Emitter emit,
  ) async {
    final result = await _weatherRepository.loadWeatherById(event.cityId);
    if (result.isSuccess) {
      emit(state.copyWith(status: WeatherStatus.success));
    } else {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    _weatherSubscription?.cancel();
    return super.close();
  }
}
