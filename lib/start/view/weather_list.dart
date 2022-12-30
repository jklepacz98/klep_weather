import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/start/view/weather_item.dart';

import '../../di/di.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherBloc>(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.status == WeatherStatus.initial ||
              state.status == WeatherStatus.loading) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              //todo what does shrinkWrap do?
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.weathers.length,
              itemBuilder: (context, index) {
                final weather = state.weathers[index];
                return WeatherItem(weather: weather);
              },
            );
          }
        },
      ),
    );
  }
}
