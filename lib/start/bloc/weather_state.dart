import 'package:equatable/equatable.dart';

import '../../database/database.dart';

enum WeatherStatus { initial, loading, success, failure }

//todo delete city
class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weathers = const [],
  });

  final WeatherStatus status;
  final List<Weather> weathers;

  WeatherState copyWith({
    WeatherStatus? status,
    String? city,
    List<Weather>? weathers,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weathers: weathers ?? this.weathers,
    );
  }

  @override
  List<Object> get props => [status, weathers];
}
