part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LanguageChangedEvent extends SettingsEvent {
  const LanguageChangedEvent({required this.countryCode});

  final String countryCode;

  @override
  List<Object?> get props => [countryCode];
}
