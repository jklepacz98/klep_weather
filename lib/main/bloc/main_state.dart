part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({
    this.locale = const Locale(languageCode),
  });

  final Locale locale;

  MainState copyWith({Locale? locale}) =>
      MainState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];

  static const String languageCode = Constants.defaultLanguage;
}
