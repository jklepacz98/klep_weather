import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klep_weather/geocoding/model/location_model.dart';
import 'package:klep_weather/geocoding/repository/geocoding_repository.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_search_event.dart';

part 'weather_search_state.dart';

class WeatherSearchBloc extends Bloc<WeatherSearchEvent, WeatherSearchState> {
  WeatherSearchBloc({
    required WeatherRepository weatherRepository,
    required GeocodingRepository geocodingRepository,
  })  : _weatherRepository = weatherRepository,
        _geocodingRepository = geocodingRepository,
        super(const WeatherSearchState()) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
    on<AutoCompleteSuggestionsEvent>(_handleAutoCompleteSuggestionsChange);
  }

  final WeatherRepository _weatherRepository;
  final GeocodingRepository _geocodingRepository;

  Future<void> _handleWeatherLoadEvent(
    WeatherLoadEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: WeatherSearchStatus.loading));
    final result = await _weatherRepository.loadWeatherByCity(event.cityName);
    if (result.isSuccess) {
      emit(state.copyWith(status: WeatherSearchStatus.success));
    } else {
      emit(state.copyWith(status: WeatherSearchStatus.failure));
    }
  }

  Future<void> _handleAutoCompleteSuggestionsChange(
    AutoCompleteSuggestionsEvent event,
    Emitter emit,
  ) async {
    final result = await _geocodingRepository.loadGeocoding(event.cityName);
    print("cos2 $result");
    if (result.isSuccess) {
      print("cos3 $result");
      emit(
        state.copyWith(
          autoCompleteSuggestions: result.value,
        ),
      );
    }
  }
}
