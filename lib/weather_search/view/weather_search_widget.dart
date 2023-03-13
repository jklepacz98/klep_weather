import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';

import '../../di/di.dart';

class WeatherSearchField extends StatelessWidget {
  const WeatherSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherSearchBloc>(),
      child: BlocBuilder<WeatherSearchBloc, WeatherSearchState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            onSubmitted: (cityName) => context
                .read<WeatherSearchBloc>()
                .add(WeatherLoadEvent(cityName: cityName)),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
            ),
          );
        },
      ),
    );
  }
}
