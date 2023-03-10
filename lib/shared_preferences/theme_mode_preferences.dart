import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModePreferences {
  ThemeModePreferences({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String getThemeMode() =>
      _sharedPreferences.getString(_themeModeKey) ?? ThemeMode.system.name;

  Future<void> setThemeMode(String themeMode) async {
    await _sharedPreferences.setString(_themeModeKey, themeMode);
  }

  static const _themeModeKey = 'themeModeKey';
}
