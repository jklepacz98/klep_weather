import 'package:injectable/injectable.dart';
import 'package:klep_weather/forecast/model/forecast_list_model.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';

@lazySingleton
class ForecastRemote {
  ForecastRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

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
