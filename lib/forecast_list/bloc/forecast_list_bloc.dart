import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_item.dart';
import 'package:klep_weather/utils/temperature.dart';

part 'forecast_list_bloc.freezed.dart';
part 'forecast_list_event.dart';
part 'forecast_list_state.dart';

@injectable
class ForecastListBloc extends Bloc<ForecastListEvent, ForecastListState> {
  ForecastListBloc({
    required ForecastRepository forecastRepository,
    @factoryParam required int cityId,
  })  : _forecastRepository = forecastRepository,
        _cityId = cityId,
        super(ForecastListState()) {
    _registerEventHandlers();
    _init();
  }

  void _registerEventHandlers() {
    on<ForecastListChangedEvent>(_handleForecastChangedEvent);
    on<ForecastListSubscribeEvent>(_handleForecastSubscribeEvent);
    on<ForecastListLoadEvent>(_handleForecastLoadEvent);
  }

  void _init() {
    add(ForecastListSubscribeEvent());
    add(ForecastListLoadEvent(cityId: _cityId));
  }

  final ForecastRepository _forecastRepository;
  StreamSubscription<List<Forecast>>? _forecastListSubscription;

  //todo should this variable be here
  final int _cityId;

  Future<void> _handleForecastChangedEvent(
    ForecastListChangedEvent event,
    Emitter emit,
  ) async {
    final forecastItemList = event.forecastList
        .map(
          (forecast) => ForecastItem(
            dt: forecast.dt,
            icon: forecast.weatherInfoIcon,
            temperature: Temperature(kelvin: forecast.mainInfoTemp),
          ),
        )
        .toList();
    emit(state.copyWith(forecastItemList: forecastItemList));
  }

  Future<void> _handleForecastSubscribeEvent(
    ForecastListSubscribeEvent event,
    Emitter emit,
  ) async {
    _forecastListSubscription =
        _forecastRepository.observeForecastsByCityId(_cityId).listen(
      (forecasts) {
        forecasts.sort((a, b) => a.dt.compareTo(b.dt));
        add(ForecastListChangedEvent(forecastList: forecasts));
      },
    );
  }

  Future<void> _handleForecastLoadEvent(
    ForecastListLoadEvent event,
    Emitter emit,
  ) async {
    final result = await _forecastRepository.loadForecastById(event.cityId);
    if (result.isSuccess) {
      emit(state.copyWith(status: ForecastListStatus.success));
    } else {
      emit(state.copyWith(status: ForecastListStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    await _forecastListSubscription?.cancel();
    return super.close();
  }
}
