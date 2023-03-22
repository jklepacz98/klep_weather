import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/utils/temperature.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';

part 'weather_list_bloc.freezed.dart';
part 'weather_list_event.dart';
part 'weather_list_state.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  WeatherListBloc(
      {required WeatherRepository weatherRepository,
      required ForecastRepository forecastRepository})
      : _weatherRepository = weatherRepository,
        _forecastRepository = forecastRepository,
        super(const WeatherListState()) {
    _registerEventHandlers();
    _init();
  }

  void _registerEventHandlers() {
    on<WeatherListSubscribeEvent>(_handleWeatherListSubscribeEvent);
    on<WeatherListChangedEvent>(_handleWeatherListChangedEvent);
    on<WeatherListLoadEvent>(_handleWeatherListLoadEvent);
    on<WeatherItemDeleteEvent>(_handleWeatherItemDeleteEvent);
  }

  void _init() {
    add(const WeatherListSubscribeEvent());
    add(const WeatherListLoadEvent());
  }

  final WeatherRepository _weatherRepository;
  StreamSubscription<List<Weather>>? _weathersSubscription;
  final ForecastRepository _forecastRepository;

  Future<void> _handleWeatherListChangedEvent(
    WeatherListChangedEvent event,
    Emitter emit,
  ) async {
    final weatherItemList = event.weatherList
        .map(
          (weather) => WeatherItem(
            cityId: weather.id,
            cityName: weather.name,
            temperature: Temperature(kelvin: weather.mainInfoTemp),
            icon: weather.weatherInfoIcon,
          ),
        )
        .toList();
    emit(state.copyWith(weathers: weatherItemList));
  }

  Future<void> _handleWeatherListSubscribeEvent(
    WeatherListSubscribeEvent event,
    Emitter emit,
  ) async {
    _weathersSubscription = _weatherRepository.observeWeathers().listen(
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
    final weathersFromLocal = await _weatherRepository.getWeathers();
    final cityIds = weathersFromLocal.map((weather) => weather.id).toList();
    final result = await _weatherRepository.loadWeathersByIds(cityIds);
    if (result.isSuccess) {
      emit(state.copyWith(status: WeatherListStatus.success));
    } else {
      emit(state.copyWith(status: WeatherListStatus.failure));
    }
  }

  Future<void> _handleWeatherItemDeleteEvent(
    WeatherItemDeleteEvent event,
    Emitter emit,
  ) async {
    unawaited(_weatherRepository.removeWeather(event.cityId));
    unawaited(_forecastRepository.removeForecastsByCityId(event.cityId));
  }

  @override
  Future<void> close() async {
    await _weathersSubscription?.cancel();
    return super.close();
  }
}
