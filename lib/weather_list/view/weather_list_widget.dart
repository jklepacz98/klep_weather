import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/start/view/weather_item_widget.dart';
import 'package:klep_weather/weather_list/bloc/weather_list_bloc.dart';

import '../../di/di.dart';

class WeatherListWidget extends StatelessWidget {
  const WeatherListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherListBloc>(),
      child: BlocBuilder<WeatherListBloc, WeatherListState>(
        builder: (context, state) {
          return Expanded(
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<WeatherListBloc>().add(WeatherListLoadEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: state.weathers.length,
                  itemBuilder: (context, index) {
                    final weatherItem = state.weathers[index];
                    //todo change key index after remove
                    return Dismissible(
                      key: UniqueKey(),
                      //todo
                      // background: const ColoredBox(color: Colors.red),
                      onDismissed: (_) {
                        final cityId = state.weathers[index].cityId;
                        context
                            .read<WeatherListBloc>()
                            .add(WeatherItemDeleteEvent(cityId: cityId));
                      },
                      child: WeatherItemWidget(weatherItem: weatherItem),
                    );
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
