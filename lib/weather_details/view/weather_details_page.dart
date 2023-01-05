import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weather.name.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            //todo move to static object?
            Center(
              child: Text(
                '${weather.mainInfoTemp.toString()}\u2103',
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
