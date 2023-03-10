import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';
import 'package:klep_weather/shared_preferences/theme_mode_preferences.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required LanguagePreferences languagePreferences,
    required ThemeModePreferences themeModePreferences,
  })  : _languagePreferences = languagePreferences,
        _themeModePreferences = themeModePreferences,
        super(
          MainState(
            locale: Locale(languagePreferences.getLanguage()),
            themeMode: ThemeMode.values.firstWhere(
              (themeMode) =>
                  themeMode.name == themeModePreferences.getThemeMode(),
            ),
          ),
        ) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<LocaleChangedEvent>(_handleLocaleChangedEvent);
    on<ThemeModeChangedEvent>(_handleThemeModeChangedEvent);
  }

  final LanguagePreferences _languagePreferences;
  final ThemeModePreferences _themeModePreferences;

  Future<void> _handleLocaleChangedEvent(
    LocaleChangedEvent event,
    Emitter emit,
  ) async {
    await _languagePreferences.setLanguage(event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _handleThemeModeChangedEvent(
    ThemeModeChangedEvent event,
    Emitter emit,
  ) async {
    await _themeModePreferences.setThemeMode(event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
