import 'package:klep_weather/utils/temperature.dart';

class ForecastItem {
  ForecastItem({
    required this.dateTime,
    required this.icon,
    required this.temperature,
  });

  final DateTime dateTime;
  final String icon;
  final Temperature temperature;
}
