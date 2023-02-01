part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class LocaleChanged extends MainEvent {
  const LocaleChanged({this.locale});

  final Locale? locale;

  @override
  List<Object?> get props => [locale];
}
