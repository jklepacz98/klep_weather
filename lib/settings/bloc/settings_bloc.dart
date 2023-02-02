import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required LanguagePreferences languagePreferences})
      : _languagePreferences = languagePreferences,
        super(SettingsState(countryCode: languagePreferences.getLanguage())) {
    _registerEventHandlers();
  }

  void _registerEventHandlers() {
    on<LanguageChangedEvent>((event, emit) async {
      await _languagePreferences.setLanguage(event.countryCode);
      emit(state.copyWith(countryCode: event.countryCode));
    });
  }

  final LanguagePreferences _languagePreferences;
}
