import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.city = "",
  });

  final String city;

  WeatherState copyWith({
    String? city,
  }) {
    return WeatherState(city: city ?? this.city);
  }

  @override
  List<Object> get props => [city];
}
