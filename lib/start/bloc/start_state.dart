import 'package:equatable/equatable.dart';

import '../../database/database.dart';

enum WeatherStatus { initial, loading, success, failure }

//todo delete city
class StartState extends Equatable {
  const StartState({
    this.status = WeatherStatus.initial,
    this.weathers = const [],
  });

  final WeatherStatus status;
  final List<Weather> weathers;

  StartState copyWith({
    WeatherStatus? status,
    String? city,
    List<Weather>? weathers,
  }) {
    print("cos3: ${this.weathers.length.toString()}");
    print("cos4: ${weathers?.length.toString()}");
    return StartState(
      status: status ?? this.status,
      weathers: weathers ?? this.weathers,
    );
  }

  @override
  List<Object> get props => [status, weathers];
}
