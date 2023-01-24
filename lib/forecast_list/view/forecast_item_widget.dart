import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';

import '../../database/database.dart';

class ForecastItemWidget extends StatelessWidget {
  const ForecastItemWidget({required Forecast forecast}) : _forecast = forecast;

  final Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 120,
          height: 160,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${DateTime.fromMillisecondsSinceEpoch(
                        //todo remove !
                        _forecast!.dt * 1000).hour.toString()}:00',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox.square(
                    dimension: 60,
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
                        child: CachedNetworkImage(
                          imageUrl: _forecast.weatherInfoIcon.toIconUrl(),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${_forecast.mainInfoTemp.toStringAsFixed(0)}\u2103',
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
