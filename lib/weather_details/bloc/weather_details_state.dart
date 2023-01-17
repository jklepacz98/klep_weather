import 'dart:core';

import 'package:equatable/equatable.dart';

import '../../database/database.dart';

//todo remove duplication
enum WeatherStatus { initial, loading, success, failure }

class WeatherDetailsState extends Equatable {
  const WeatherDetailsState(
      {this.status = WeatherStatus.initial, this.weather});

  final WeatherStatus status;
  final Weather? weather;

  WeatherDetailsState copyWith({
    WeatherStatus? status,
    Weather? weather,
  }) {
    return WeatherDetailsState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
