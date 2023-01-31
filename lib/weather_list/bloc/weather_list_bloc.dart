import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klep_weather/utils/temperature.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';
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
  StreamSubscription<List<Weather>>? _weathersSubscription;

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

  @override
  Future<void> close() async {
    await _weathersSubscription?.cancel();
    return super.close();
  }
}
