import 'package:injectable/injectable.dart';
import 'package:klep_weather/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LanguagePreferences {
  LanguagePreferences({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String getLanguage() =>
      _sharedPreferences.getString(_languageKey) ?? Constants.defaultLanguage;

  Future<void> setLanguage(String language) async {
    await _sharedPreferences.setString(_languageKey, language);
  }

  static const _languageKey = 'languageKey';
}
