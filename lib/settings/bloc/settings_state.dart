part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.languageCode});

  final String languageCode;

  SettingsState copyWith({
    String? languageCode,
  }) =>
      SettingsState(languageCode: languageCode ?? this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
