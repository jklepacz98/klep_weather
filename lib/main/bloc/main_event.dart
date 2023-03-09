part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class LocaleChangedEvent extends MainEvent {
  const LocaleChangedEvent({required this.locale});

  final Locale locale;

  @override
  List<Object> get props => [locale];
}

class ThemeModeChangedEvent extends MainEvent {
  const ThemeModeChangedEvent({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
