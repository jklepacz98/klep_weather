import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';

class ForecastRepository {
  ForecastRepository({
    required ForecastRemote forecastRemote,
    required ForecastLocal forecastLocal,
  })  : _forecastRemote = forecastRemote,
        _forecastLocal = forecastLocal;

  final ForecastRemote _forecastRemote;
  final ForecastLocal _forecastLocal;

  Future<void> loadForecastById(int id) async {
    final result = await _forecastRemote.loadForecastById(id);
  }
}
