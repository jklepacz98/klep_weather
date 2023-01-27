import 'package:klep_weather/forecast/entity/forecast_entity.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';

class ForecastRepository {
  ForecastRepository({required ForecastLocal forecastLocal})
      : _forecastLocal = forecastLocal;

  final ForecastLocal _forecastLocal;

  Stream<List<ForecastEntity>> observeForecastsByCityId(int cityId) =>
      //todo maybe extract to another function
      _forecastLocal.observerForecastsByCityId(cityId).map(
            (localModelList) => localModelList
                .map(
                  (localModel) =>
                      ForecastEntity.fromForecastLocalModel(localModel),
                )
                .toList(),
          );
}
