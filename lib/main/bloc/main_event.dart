part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class LocaleChangedEvent extends MainEvent {
  const LocaleChangedEvent({this.locale});

  final Locale? locale;

  @override
  List<Object?> get props => [locale];
}
