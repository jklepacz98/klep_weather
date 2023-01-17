import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../weather_details/view/weather_details_page.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(weather.name.toString()),
          tileColor: Colors.white,
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => WeatherDetailsPage(weather: weather));
            Navigator.push(context, route);
          },
        ),
      ),
    );
  }
}
