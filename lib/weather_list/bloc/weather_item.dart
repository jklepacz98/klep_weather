import 'package:klep_weather/utils/temperature.dart';

class WeatherItem {
  WeatherItem({
    required this.cityId,
    required this.cityName,
    required this.temperature,
    required this.icon,
  });

  final int cityId;
  final String cityName;
  final Temperature temperature;
  final String icon;
}
