import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/network/result.dart';

import '../model/forecast_list_model.dart';

class ForecastRepository {
  ForecastRepository({
    required ForecastRemote forecastRemote,
    required ForecastLocal forecastLocal,
  })  : _forecastRemote = forecastRemote,
        _forecastLocal = forecastLocal;

  final ForecastRemote _forecastRemote;
  final ForecastLocal _forecastLocal;

  Future<Result<ForecastListModel>> loadForecastById(int id) async {
    final result = await _forecastRemote.loadForecastById(id);
    if (result.isSuccess) {
      final forecastList = result.value!;
      _forecastLocal.removeForecastsByCityId(forecastList.city.id);
      final forecastTableCompanionList =
          forecastList.toForecastTableCompanions();
      _forecastLocal.saveForecast(forecastTableCompanionList);
    }
    return result;
  }

  Stream<List<Forecast>> observeForecasts() async* {
    yield* _forecastLocal.observerForecasts();
  }
}
