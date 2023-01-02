import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:klep_weather/start/bloc/weather_event.dart';
import 'package:klep_weather/start/bloc/weather_state.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

import '../../database/database.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        //todo const?
        super(const WeatherState()) {
    on<WeatherListChangedEvent>(_handleWeatherListChangedEvent);
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
    on<WeatherGetEvent>(_handleWeatherGetEvent);
    on<WeatherSubscribeEvent>(_handleWeatherSubscribeEvent);
    //todo
    add(WeatherSubscribeEvent());
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<List<Weather>>? _weathersSubscription;

  Future<void> _handleWeatherListChangedEvent(
    WeatherListChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(weathers: event.weathers));
  }

  Future<void> _handleWeatherLoadEvent(
    WeatherLoadEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    final weatherResult = await _weatherRepository.loadWeather(event.city);
    if (weatherResult.isSuccess) {
      emit(state.copyWith(status: WeatherStatus.success));
      //todo
      add(WeatherGetEvent());
    } else {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> _handleWeatherGetEvent(
    WeatherGetEvent event,
    Emitter emit,
  ) async {
    final weathers = await _weatherRepository.getWeathers();
    add(WeatherListChangedEvent(weathers: weathers));
  }

  Future<void> _handleWeatherSubscribeEvent(
    WeatherSubscribeEvent event,
    Emitter emit,
  ) async {
    _weathersSubscription = _weatherRepository.observerWeathers().listen(
      (weathers) {
        add(WeatherListChangedEvent(weathers: weathers));
      },
    );
  }
}
