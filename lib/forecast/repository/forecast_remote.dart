import 'package:klep_weather/forecast/model/forecast_list_model.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';

class ForecastRemote {
  ForecastRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  //todo create model for forecast, even though it has the same fields?
  Future<Result<ForecastListModel>> loadForecastById(
    int id,
    String language,
  ) async {
    try {
      final response =
          await _restClient.getForecastById(id: id, language: language);
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure('GET forecast request failed');
    }
  }
}
