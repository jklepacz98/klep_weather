import 'package:klep_weather/geocoding/model/location_model.dart';
import 'package:klep_weather/geocoding/repository/geocoding_local.dart';
import 'package:klep_weather/geocoding/repository/geocoding_remote.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';

import '../../network/result.dart';
import '../model/geocoding_model.dart';

class GeocodingRepository {
  GeocodingRepository({
    required GeocodingRemote geocodingRemote,
    required LanguagePreferences languagePreferences,
  })  : _geocodingRemote = geocodingRemote,
        _languagePreferences = languagePreferences;

  final GeocodingRemote _geocodingRemote;
  final LanguagePreferences _languagePreferences;

  Future<Result<List<LocationModel>>> loadGeocoding(String cityName) async {
    final language = _languagePreferences.getLanguage();
    return _geocodingRemote.loadGeocoding(cityName, language);
  }
}
