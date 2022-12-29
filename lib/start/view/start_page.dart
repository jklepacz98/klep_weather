import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/start/bloc/weather_bloc.dart';
import 'package:klep_weather/start/bloc/weather_state.dart';
import 'package:klep_weather/start/view/weather_list.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

class StartPage extends StatelessWidget {
  final _weatherRepository = getIt<WeatherRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //todo change or remove color
        backgroundColor: Colors.amber,
        body: BlocProvider(
            create: (context) => getIt<WeatherBloc>(),
            child: BlocBuilder<WeatherBloc, WeatherState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Center(child: WeatherList(weathers: state.weathers));
              },
            )));
  }
}
