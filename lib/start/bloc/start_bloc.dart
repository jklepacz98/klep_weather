import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:klep_weather/start/bloc/start_event.dart';
import 'package:klep_weather/start/bloc/start_state.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

import '../../database/database.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        //todo const?
        super(const StartState()) {
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
    on<WeatherSubscribeEvent>(_handleWeatherSubscribeEvent);
    on<WeatherListChangedEvent>(_handleWeatherListChangedEvent);
    on<WeatherListLoadEvent>(_handleWeatherListLoadEvent);
    //todo should init be here?
    add(WeatherSubscribeEvent());
    add(WeatherListLoadEvent());
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<List<Weather>>? _weathersSubscription;

  Future<void> _handleWeatherLoadEvent(
    WeatherLoadEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    final weatherResult =
        await _weatherRepository.loadWeatherByCity(event.city);
    if (weatherResult.isSuccess) {
      emit(state.copyWith(status: WeatherStatus.success));
    } else {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> _handleWeatherSubscribeEvent(
    WeatherSubscribeEvent event,
    Emitter emit,
  ) async {
    _weathersSubscription = _weatherRepository.observeWeathers().listen(
      (weathers) {
        add(WeatherListChangedEvent(weathers: weathers));
      },
    );
  }

  Future<void> _handleWeatherListChangedEvent(
    WeatherListChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(weathers: event.weathers));
  }

  Future<void> _handleWeatherListLoadEvent(
    WeatherListLoadEvent event,
    Emitter emit,
  ) async {
    final weathersFromLocal = await _weatherRepository.getWeathers();
    final cityIds = weathersFromLocal.map((weather) => weather.id).toList();
    print("cos1 ${weathersFromLocal.toString()}");
    final result = await _weatherRepository.loadWeathersByIds(cityIds);
    final weathersFromRemote = result.value!.weatherList;
    final weathersFromLocal2 = await _weatherRepository.getWeathers();
    print("cos2 ${weathersFromRemote.toString()}");
    print("cos3 ${weathersFromLocal2.toString()}");
  }
}
