import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../weather_details/view/weather_details_page.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final route = MaterialPageRoute(
            builder: (context) => WeatherDetailsPage(weather: weather));
        Navigator.push(context, route);
      },
      title: Text(weather.name.toString()),
    );
  }
}
