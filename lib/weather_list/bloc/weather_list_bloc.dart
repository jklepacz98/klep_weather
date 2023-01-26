import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';

import '../../database/database.dart';

part 'weather_list_event.dart';
part 'weather_list_state.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  WeatherListBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(const WeatherListState()) {
    _registerEventHandlers();
    _init();
  }

  void _registerEventHandlers() {
    on<WeatherListSubscribeEvent>(_handleWeatherListSubscribeEvent);
    on<WeatherListChangedEvent>(_handleWeatherListChangedEvent);
    on<WeatherListLoadEvent>(_handleWeatherListLoadEvent);
  }

  void _init() {
    add(WeatherListSubscribeEvent());
    add(WeatherListLoadEvent());
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<List<WeatherEntity>>? _weathersSubscription;

  Future<void> _handleWeatherListChangedEvent(
    WeatherListChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(weathers: event.weatherList));
  }

  Future<void> _handleWeatherListSubscribeEvent(
    WeatherListSubscribeEvent event,
    Emitter emit,
  ) async {
    _weathersSubscription = _weatherRepository.observeWeatherList().listen(
      (weathers) {
        weathers.sort((a, b) => a.name.compareTo(b.name));
        add(WeatherListChangedEvent(weatherList: weathers));
      },
    );
  }

  Future<void> _handleWeatherListLoadEvent(
    WeatherListLoadEvent event,
    Emitter emit,
  ) async {
    final weathersFromLocal = await _weatherRepository.getWeatherList();
    final cityIds = weathersFromLocal.map((weather) => weather.id).toList();
    final result = await _weatherRepository.loadWeatherListByIds(cityIds);
    if (result.isSuccess) {
      emit(state.copyWith(status: WeatherListStatus.success));
    } else {
      emit(state.copyWith(status: WeatherListStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    _weathersSubscription?.cancel();
    return super.close();
  }
}
