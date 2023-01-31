import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';

class StartSnackbarWidget extends StatelessWidget {
  const StartSnackbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherSearchBloc>(),
      child: BlocListener<WeatherSearchBloc, WeatherSearchState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state.status == WeatherSearchStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Success'),
              ),
            );
          } else if (state.status == WeatherSearchStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failure'),
              ),
            );
          }
        },
        child: Container(),
      ),
    );
  }
}
