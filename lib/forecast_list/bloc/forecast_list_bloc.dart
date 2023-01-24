import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../database/database.dart';
import '../../forecast/repository/forecast_repository.dart';

part 'forecast_list_event.dart';
part 'forecast_list_state.dart';

class ForecastListBloc extends Bloc<ForecastListEvent, ForecastListState> {
  ForecastListBloc({
    required ForecastRepository forecastRepository,
    required int cityId,
  })  : _forecastRepository = forecastRepository,
        _cityId = cityId,
        super(const ForecastListState()) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<ForecastListChangedEvent>(_handleForecastChangedEvent);
    on<ForecastListSubscribeEvent>(_handleForecastSubscribeEvent);
    on<ForecastListLoadEvent>(_handleForecastLoadEvent);
  }

  final ForecastRepository _forecastRepository;
  StreamSubscription<List<Forecast>>? _forecastListSubscription;

  //todo should this variable be here
  final int _cityId;

  Future<void> _handleForecastChangedEvent(
    ForecastListChangedEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(forecastList: event.forecastList));
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
    _forecastListSubscription?.cancel();
    return super.close();
  }
}
