import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(weather.name.toString()),
    );
  }
}
