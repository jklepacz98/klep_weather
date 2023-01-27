import 'package:klep_weather/database/database.dart';

class ForecastLocal {
  ForecastLocal({required AppDatabase database}) : _database = database;

  final AppDatabase _database;

  Future<void> saveForecast(
      List<ForecastLocalModel> forecastLocalModelList) async {
    final forecastLocalModelsCompanionList = forecastLocalModelList
        .map((localModel) => localModel.toCompanion(false))
        .toList();
    await _database.addForecasts(forecastLocalModelsCompanionList);
  }

  Future<void> removeForecastsByCityId(int cityId) =>
      _database.removeForecastsByCityId(cityId);

  Stream<List<ForecastLocalModel>> observerForecastsByCityId(int cityId) =>
      _database.observeForecastsByCityId(cityId);
}
