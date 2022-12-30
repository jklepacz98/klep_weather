import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';

class WeatherItem extends StatelessWidget {
  WeatherItem({required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(4.0),
        child: Text(weather.name.toString()),
      ),
    );
  }
}
