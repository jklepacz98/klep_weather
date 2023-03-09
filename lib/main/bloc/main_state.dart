part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({required this.locale, required this.themeMode});

  final Locale locale;
  final ThemeMode themeMode;

  MainState copyWith({Locale? locale, ThemeMode? themeMode}) =>
      MainState(locale: locale ?? this.locale, themeMode: themeMode ?? this.themeMode);

  @override
  List<Object?> get props => [locale, themeMode];
}
