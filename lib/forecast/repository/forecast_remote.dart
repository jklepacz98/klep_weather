import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/weather/model/weather_models.dart';

import '../../network/result.dart';

class ForecastRemote {
  ForecastRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  //todo create model for forecast, even though it has the same fields?
  Future<Result<WeatherModels>> loadForecastById(int id) async {
    try {
      final response = await _restClient.getForecastById(id: id);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure("GET forecas request failed");
    }
  }
}
