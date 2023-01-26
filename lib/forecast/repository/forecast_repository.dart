import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/entity/forecast_entity.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/network/result.dart';

import '../model/forecast_list_remote_model.dart';

class ForecastRepository {
  ForecastRepository({
    required ForecastRemote forecastRemote,
    required ForecastLocal forecastLocal,
  })  : _forecastRemote = forecastRemote,
        _forecastLocal = forecastLocal;

  final ForecastRemote _forecastRemote;
  final ForecastLocal _forecastLocal;

  Future<Result<List<ForecastEntity>>> loadForecastById(int id) async {
    final remoteResult = await _forecastRemote.loadForecastById(id);
    if (remoteResult.isSuccess) {
      final remoteModelList = remoteResult.value!;
      await _forecastLocal.removeForecastsByCityId(remoteModel.city.id);
      final forecastTableCompanionList =
          remoteModelList.toForecastTableCompanions();
      await _forecastLocal.saveForecast(forecastTableCompanionList);
    }
    return remoteResult;
  }

  Stream<List<ForecastEntity>> observeForecastsByCityId(int cityId) async* {
    yield* _forecastLocal.observerForecastsByCityId(cityId);
  }
}
