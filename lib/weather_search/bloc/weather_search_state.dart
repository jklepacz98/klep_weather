part of 'weather_search_bloc.dart';

enum WeatherSearchStatus { initial, loading, success, failure }

class WeatherSearchState extends Equatable {
  const WeatherSearchState({
    this.status = WeatherSearchStatus.initial,
    this.autoCompleteSuggestions = const [],
  });

  final WeatherSearchStatus status;
  final List<LocationModel> autoCompleteSuggestions;

  WeatherSearchState copyWith({
    WeatherSearchStatus? status,
    List<LocationModel>? autoCompleteSuggestions,
  }) =>
      WeatherSearchState(
        status: status ?? this.status,
        autoCompleteSuggestions:
            autoCompleteSuggestions ?? this.autoCompleteSuggestions,
      );

  @override
  List<Object> get props => [status, autoCompleteSuggestions];
}
