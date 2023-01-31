import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather_details/view/weather_details_page.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget({
    required this.weatherItem,
    super.key,
  });

  final WeatherItem weatherItem;

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
          title: Text(weatherItem.cityName),
          onTap: () {
            final route = MaterialPageRoute(
              builder: (context) =>
                  WeatherDetailsPage(weatherItem: weatherItem),
            );
            Navigator.push(context, route);
          },
          subtitle: Text(weatherItem.temperature.toStringAsCelsius()),
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
                  imageUrl: weatherItem.icon.toIconUrl(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
