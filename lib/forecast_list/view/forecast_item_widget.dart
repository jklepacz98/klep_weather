import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/forecast/entity/forecast_entity.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';

class ForecastItemWidget extends StatelessWidget {
  const ForecastItemWidget({
    required ForecastEntity forecastEntity,
    super.key,
  }) : _forecastEntity = forecastEntity;

  final ForecastEntity _forecastEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 120,
          height: 160,
          child: DecoratedBox(
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
                        _forecastEntity!.dt * 1000).hour.toString()}:00',
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
                          imageUrl: _forecastEntity.weatherInfoIcon.toIconUrl(),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${_forecastEntity.mainInfoTemp.kelvin.toStringAsFixed(0)}\u2103',
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
