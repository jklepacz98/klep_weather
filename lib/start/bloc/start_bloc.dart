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
    //todo should init be here?
    add(WeatherSubscribeEvent());
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
        print("cos1");
        print("cos2: ${weathers.length.toString()}");
        emit(state.copyWith(weathers: weathers));
      },
    );
  }
}
