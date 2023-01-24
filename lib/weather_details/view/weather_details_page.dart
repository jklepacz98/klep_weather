import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

import '../../database/database.dart';
import '../../di/di.dart';

class WeatherDetailsPage extends StatelessWidget {
  WeatherDetailsPage({super.key, required Weather weather})
      : _cityName = weather.name,
        _cityId = weather.id;

  final String _cityName;
  final int _cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cityName.toString()),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[900],
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SafeArea(
              child: BlocProvider(
                create: (context) => getIt<WeatherDetailsBloc>(param1: _cityId),
                child: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox.square(
                            dimension: 100,
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
                                  child:
                                      (state.weather?.weatherInfoIcon != null)
                                          ? CachedNetworkImage(
                                              imageUrl: state
                                                  .weather?.weatherInfoIcon
                                                  .toIconUrl())
                                          : Container()),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            //todo remove !
                            '${toCelsius(state.weather?.mainInfoTemp)?.toStringAsFixed(0)}\u2103',
                            style: const TextStyle(fontSize: 64),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            BlocProvider(
              create: (context) => getIt<WeatherDetailsBloc>(param1: _cityId),
              child: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
                builder: (context, state) {
                  print("cos1 ${state.forecastList.toString()}");
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.forecastList?.length ?? 0,
                      itemBuilder: (context, index) {
                        print("cos2 ${state.forecastList.toString()}");
                        //todo
                        final forecast = state.forecastList?[index];
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
                                            forecast!.dt * 1000).hour.toString()}:00',
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
                                              imageUrl: forecast.weatherInfoIcon
                                                  ?.toIconUrl(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '${toCelsius(forecast.mainInfoTemp)?.toStringAsFixed(0)}\u2103',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //todo move to bloc?
  static double? toCelsius(double? kelwinTemperature) {
    if (kelwinTemperature != null) {
      return kelwinTemperature - absoluteZero;
    } else {
      return null;
    }
  }

  static double absoluteZero = 273.15;
}
