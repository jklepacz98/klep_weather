import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_search_event.dart';

part 'weather_search_state.dart';

part 'weather_search_bloc.freezed.dart';

class WeatherSearchBloc extends Bloc<WeatherSearchEvent, WeatherSearchState> {
  WeatherSearchBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherSearchState(status: WeatherSearchStatus.initial)) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _handleWeatherLoadEvent(
    WeatherLoadEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: WeatherSearchStatus.loading));
    final result = await _weatherRepository.loadWeatherByCity(event.city);
    if (result.isSuccess) {
      emit(state.copyWith(status: WeatherSearchStatus.success));
    } else {
      emit(state.copyWith(status: WeatherSearchStatus.failure));
    }
  }
}
