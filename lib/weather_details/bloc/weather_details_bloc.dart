import 'dart:async';
import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/temperature.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';

part 'weather_details_bloc.freezed.dart';
part 'weather_details_event.dart';
part 'weather_details_state.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherDetailsBloc({
    required WeatherRepository weatherRepository,
    required int cityId,
  })  : _weatherRepository = weatherRepository,
        _cityId = cityId,
        super(WeatherDetailsState(weatherItem: null)) {
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

  Future<void> _handleWeatherChangedEvent(
    WeatherChangedEvent event,
    Emitter emit,
  ) async {
    final weather = event.weather;
    final weatherItem = WeatherItem(
      cityId: weather.id,
      cityName: weather.name,
      temperature: Temperature(kelvin: weather.mainInfoTemp),
      icon: weather.weatherInfoIcon,
    );
    emit(state.copyWith(weatherItem: weatherItem));
  }

  Future<void> _handleWeatherSubscribeEvent(
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
    await _weatherSubscription?.cancel();
    return super.close();
  }
}
