part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState({required this.locale});

  final Locale locale;

  MainState copyWith({Locale? locale}) =>
      MainState(locale: locale ?? this.locale);

  @override
  List<Object?> get props => [locale];
}
