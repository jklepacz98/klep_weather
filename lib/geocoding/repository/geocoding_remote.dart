import 'package:klep_weather/geocoding/model/geocoding_model.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/network/result.dart';

class GeocodingRemote {
  GeocodingRemote({
    required RestClient restClient,
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<Result<GeocodingModel>> loadGeocoding(
    String cityName,
    String language,
  ) async {
    try {
      final response = await _restClient.getGeocoding(
        language: language,
        cityName: cityName,
      );
      return Result.success(response);
    } on Exception catch (_) {
      return Result.failure('GET');
    }
  }
}
