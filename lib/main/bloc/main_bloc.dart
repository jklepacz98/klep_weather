import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required LanguagePreferences languagePreferences})
      : _languagePreferences = languagePreferences,
        super(
          MainState(
            locale: Locale(languagePreferences.getLanguage()),
            themeMode: ThemeMode.system,
          ),
        ) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<LocaleChangedEvent>(_handleLocaleChangedEvent);
    on<ThemeModeChangedEvent>(_handleThemeModeChangedEvent);
  }

  final LanguagePreferences _languagePreferences;

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
    print("cos1 ${event.themeMode}");
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
