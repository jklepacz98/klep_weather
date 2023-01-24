import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_search_event.dart';
part 'weather_search_state.dart';

class WeatherSearchBloc extends Bloc<WeatherSearchEvent, WeatherSearchState> {
  WeatherSearchBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(const WeatherSearchState()) {
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
