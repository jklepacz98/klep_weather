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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_cityName.toString()),
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
            SafeArea(
              child: BlocProvider(
                create: (context) => getIt<WeatherDetailsBloc>(param1: _cityId),
                child: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              //todo
                              state.weather?.weatherInfoIcon.toIconUrl() ?? "",
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
                          padding: const EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 80,
                              height: 50,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.rectangle),
                                child: Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          forecast!.dt * 1000)
                                      .toString(),
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
