import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_event.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

import '../../database/database.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherDetailsBloc({
    required WeatherRepository weatherRepository,
    required ForecastRepository forecastRepository,
    required int cityId,
  })  : _weatherRepository = weatherRepository,
        _forecastRepository = forecastRepository,
        _cityId = cityId,
        super(const WeatherDetailsState(status: WeatherStatus.initial)) {
    _registerEventHandlers();
    _init();
  }

  //todo change name
  void _init() {
    add(WeatherSubscribeEvent());
    add(WeatherLoadEvent(cityId: _cityId));
    print("cos6 heh");
    add(ForecastSubscribeEvent());
    add(ForecastLoadEvent(cityId: _cityId));
  }

  void _registerEventHandlers() {
    on<WeatherChangedEvent>(_handleWeatherChangedEvent);
    on<WeatherSubscribeEvent>(_handleWeatherSubscribeEvent);
    on<WeatherLoadEvent>(_handleWeatherLoadEvent);
    on<ForecastChangedEvent>(_handleForecastChangedEvent);
    on<ForecastSubscribeEvent>(_handleForecastSubscribeEvent);
    on<ForecastLoadEvent>(_handleForecastLoadEvent);
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<Weather>? _weatherSubscription;
  final ForecastRepository _forecastRepository;
  StreamSubscription<List<Forecast>>? _forecastListSubscription;

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

  Future<void> _handleForecastChangedEvent(
    ForecastChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(forecastList: event.forecastList));
  }

  Future<void> _handleForecastSubscribeEvent(
    ForecastSubscribeEvent event,
    Emitter emit,
  ) async {
    print("cos3 subscribe");
    _forecastListSubscription =
        _forecastRepository.observeForecastsByCityId(_cityId).listen(
      (forecasts) {
        //todo  get rid of !
        print("cos4 ${forecasts.length.toString()}");
        forecasts.sort((a, b) => a.dt!.compareTo(b.dt!));
        add(ForecastChangedEvent(forecastList: forecasts));
      },
    );
  }

  Future<void> _handleForecastLoadEvent(
    ForecastLoadEvent event,
    Emitter emit,
  ) async {
    final result = await _forecastRepository.loadForecastById(event.cityId);
    if (result.isSuccess) {
      print("cos5 ${result.value?.forecastList.length.toString()}");
      emit(state.copyWith(status: WeatherStatus.success));
    } else {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    _forecastListSubscription?.cancel();
    _weatherSubscription?.cancel();
    return super.close();
  }
}
