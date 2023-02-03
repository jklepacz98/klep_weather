import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/model/forecast_list_model.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/network/result.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';

class ForecastRepository {
  ForecastRepository({
    required ForecastRemote forecastRemote,
    required ForecastLocal forecastLocal,
    required LanguagePreferences languagePreferences,
  })  : _forecastRemote = forecastRemote,
        _forecastLocal = forecastLocal,
        _languagePreferences = languagePreferences;

  final ForecastRemote _forecastRemote;
  final ForecastLocal _forecastLocal;
  final LanguagePreferences _languagePreferences;

  Future<Result<ForecastListModel>> loadForecastById(int id) async {
    final language = _languagePreferences.getLanguage();
    final result = await _forecastRemote.loadForecastById(id, language);
    if (result.isSuccess) {
      final forecastList = result.value!;
      await _forecastLocal.removeForecastsByCityId(forecastList.city.id);
      final forecastCompanionList = forecastList.toForecastCompanions();
      await _forecastLocal.saveForecast(forecastCompanionList);
    }
    return result;
  }

  Stream<List<Forecast>> observeForecastsByCityId(int cityId) async* {
    yield* _forecastLocal.observerForecastsByCityId(cityId);
  }
}
