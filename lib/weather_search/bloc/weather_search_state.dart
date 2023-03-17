part of 'weather_search_bloc.dart';

enum WeatherSearchStatus { initial, loading, success, failure }

class WeatherSearchState extends Equatable {
  const WeatherSearchState({
    this.status = WeatherSearchStatus.initial,
    required this.suggestions,
  });

  final WeatherSearchStatus status;
  final List<LocationModel> suggestions;

  WeatherSearchState copyWith({
    WeatherSearchStatus? status,
    List<LocationModel>? suggestions,
  }) =>
      WeatherSearchState(
        status: status ?? this.status,
        suggestions: suggestions ?? this.suggestions,
      );

  @override
  List<Object> get props => [status, suggestions];
}
