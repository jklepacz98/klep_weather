import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

@lazySingleton
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required LanguagePreferences languagePreferences})
      : _languagePreferences = languagePreferences,
        super(MainState(locale: Locale(languagePreferences.getLanguage()))) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<LocaleChangedEvent>(_handleLocaleChangedEvent);
  }

  final LanguagePreferences _languagePreferences;

  Future<void> _handleLocaleChangedEvent(
      LocaleChangedEvent event, Emitter emit) async {
    await _languagePreferences.setLanguage(event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }
}
