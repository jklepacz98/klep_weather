import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather_details/view/weather_details_page.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color: Colors.blueGrey[800]!,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(weather.name),
          onTap: () {
            final route = MaterialPageRoute(
                builder: (context) => WeatherDetailsPage(weather: weather));
            Navigator.push(context, route);
          },
          //todo to Celsius
          subtitle: Text(
              "${toCelsius(weather.mainInfoTemp).toStringAsFixed(0)}\u2103"),
          trailing: SizedBox.square(
            dimension: 50,
            child: Card(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[500]!,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: weather.weatherInfoIcon.toIconUrl(),
                ),
              ),
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
