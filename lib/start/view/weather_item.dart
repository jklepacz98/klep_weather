import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather_details/view/weather_details_page.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.blueGrey[800]!,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(weather.name.toString()),
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => WeatherDetailsPage(weather: weather));
            Navigator.push(context, route);
          },
          //todo to Celsius
          subtitle: Text(
              "${toCelsius(weather.mainInfoTemp!).toStringAsFixed(0)}\u2103"),
          trailing: SizedBox.square(
            dimension: 50,
            child: Card(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue[500]!,
                      Colors.deepPurple,
                    ]),
                  ),
                  child: (weather.weatherInfoIcon != null)
                      ? CachedNetworkImage(
                          imageUrl: weather.weatherInfoIcon.toIconUrl())
                      : Container()),
            ),
          ),
        ),
      ),
    );
  }

  //todo move to bloc?
  static double toCelsius(double kelwinTemperature) =>
      (kelwinTemperature - absoluteZero);
  static double absoluteZero = 273.15;
}
