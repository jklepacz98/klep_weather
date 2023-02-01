import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/forecast_list/view/forecast_list_horizontal_widget.dart';
import 'package:klep_weather/utils/weather_icon_utils.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';
import 'package:klep_weather/weather_list/bloc/weather_item.dart';

class WeatherDetailsPage extends StatelessWidget {
  WeatherDetailsPage({
    required WeatherItem weatherItem,
    super.key,
  })  : _cityName = weatherItem.cityName,
        _cityId = weatherItem.cityId;

  final String _cityName;
  final int _cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cityName),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
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
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue[500]!,
                                    Colors.deepPurple,
                                  ],
                                ),
                              ),
                              child: (state.weatherItem?.icon != null)
                                  ? CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      imageUrl:
                                          state.weatherItem?.icon.toIconUrl() ??
                                              '',
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          state.weatherItem?.temperature.toStringAsCelsius() ??
                              '',
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
    );
  }
}
