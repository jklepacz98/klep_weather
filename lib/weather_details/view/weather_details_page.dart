import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';

import '../../database/database.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.blue[600]!,
              Colors.blue[400]!,
              Colors.indigo[200]!,
            ],
          ),
        ),
        child: Column(
          children: [
            //todo move to static object?
            Center(
              child: Text(
                '${weather.mainInfoTemp.toString()}\u2103',
                style: const TextStyle(fontSize: 64),
              ),
            ),
            CachedNetworkImage(imageUrl: weather.weatherInfoIcon?.toIconUrl())
          ],
        ),
      ),
    );
  }
}
