import 'package:equatable/equatable.dart';

import '../../database/database.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.city = "",
    this.weathers = const [],
  });

  final String city;
  final List<Weather> weathers;

  WeatherState copyWith({
    String? city,
    List<Weather>? weathers,
  }) {
    return WeatherState(
        city: city ?? this.city, weathers: weathers ?? this.weathers);
  }

  @override
  List<Object> get props => [city, weathers];
}
