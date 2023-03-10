import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_item.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';

class ForecastItemWidget extends StatelessWidget {
  const ForecastItemWidget({
    required ForecastItem forecastItem,
    super.key,
  }) : _forecastItem = forecastItem;

  final ForecastItem _forecastItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 120,
          height: 160,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blue.shade200
                  : Colors.blueGrey[800],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${DateTime.fromMillisecondsSinceEpoch(
                      //todo remove !
                      _forecastItem.dt * 1000,
                    ).hour.toString()}:00',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox.square(
                    dimension: 60,
                    child: Card(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.blue[500]!,
                            Colors.deepPurple,
                          ]),
                        ),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          imageUrl: _forecastItem.icon.toIconUrl(),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _forecastItem.temperature.toStringAsCelsius(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
