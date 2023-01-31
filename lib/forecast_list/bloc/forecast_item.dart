import 'package:klep_weather/utils/temperature.dart';

class ForecastItem {
  ForecastItem({
    required this.dt,
    required this.icon,
    required this.temperature,
  });

  final int dt;
  final String icon;
  final Temperature temperature;
}
