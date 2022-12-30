import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/start/bloc/weather_bloc.dart';
import 'package:klep_weather/start/bloc/weather_event.dart';
import 'package:klep_weather/start/view/weather_list.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

import '../bloc/weather_state.dart';

class StartPage extends StatelessWidget {
  final _weatherRepository = getIt<WeatherRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        //todo change or remove color
        backgroundColor: Colors.amber,
        body: Center(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(16.0),
                  child: BlocProvider(
                    create: (context) => getIt<WeatherBloc>(),
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        return TextField(
                          onSubmitted: (city) => context
                              .read<WeatherBloc>()
                              .add(WeatherLoadEvent(city: city)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City',
                          ),
                        );
                      },
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: WeatherList(),
              )
            ],
          ),
        ));
  }
}
