import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/forecast_list/view/forecast_list_horizontal_widget.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather/entity/weather_entity.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

class WeatherDetailsPage extends StatelessWidget {
  WeatherDetailsPage({required WeatherEntity weatherEntity, super.key})
      : _cityName = weatherEntity.name,
        _cityId = weatherEntity.id;

  final String _cityName;
  final int _cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cityName),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[900],
      extendBodyBehindAppBar: true,
      body: Container(
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
                          padding: const EdgeInsets.all(16),
                          child: SizedBox.square(
                            dimension: 100,
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
                                  child:
                                      (state.weatherEntity?.weatherInfoIcon !=
                                              null)
                                          ? CachedNetworkImage(
                                              imageUrl: state.weatherEntity
                                                  ?.weatherInfoIcon
                                                  .toIconUrl(),
                                            )
                                          : Container()),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            //todo remove !
                            '${toCelsius(state.weatherEntity?.mainInfoTemp.celsius)?.toStringAsFixed(0)}\u2103',
                            style: const TextStyle(fontSize: 64),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: ForecastListHorizontalWidget(cityId: _cityId),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
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
