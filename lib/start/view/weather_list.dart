import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/start/bloc/start_event.dart';
import 'package:klep_weather/start/view/weather_item.dart';

import '../../di/di.dart';
import '../bloc/start_bloc.dart';
import '../bloc/start_state.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StartBloc>(),
      child: BlocBuilder<StartBloc, StartState>(
        builder: (context, state) {
          return Expanded(
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<StartBloc>().add(WeatherListLoadEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: state.weathers.length,
                  itemBuilder: (context, index) {
                    final weather = state.weathers[index];
                    return WeatherItem(weather: weather);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
