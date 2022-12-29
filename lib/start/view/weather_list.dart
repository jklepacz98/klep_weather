import 'package:flutter/cupertino.dart';
import 'package:klep_weather/start/view/weather_item.dart';

import '../../database/database.dart';

class WeatherList extends StatelessWidget {
  WeatherList({required this.weathers});

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //todo
        itemCount: weathers.length,
        itemBuilder: (context, index) {
          final weather = weathers[index];
          return WeatherItem(weather: weather);
        });
  }
}
