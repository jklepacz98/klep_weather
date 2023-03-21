part of 'main_bloc.dart';

@freezed
abstract class MainEvent with _$MainEvent {
  const factory MainEvent.localeChanged({required Locale locale}) = LocaleChangedEvent;
}

// class LocaleChangedEvent extends MainEvent {
//   const LocaleChangedEvent({this.locale});
//
//   final Locale? locale;
//
//   @override
//   List<Object?> get props => [locale];
// }
