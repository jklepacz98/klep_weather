part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.countryCode});

  final String countryCode;

  SettingsState copyWith({
    String? countryCode,
  }) =>
      SettingsState(countryCode: countryCode ?? this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
