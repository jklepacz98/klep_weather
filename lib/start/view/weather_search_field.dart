import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '../bloc/start_bloc.dart';
import '../bloc/start_event.dart';
import '../bloc/start_state.dart';

class WeatherSearchField extends StatelessWidget {
  const WeatherSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StartBloc>(),
      child: BlocBuilder<StartBloc, StartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            onSubmitted: (city) =>
                context.read<StartBloc>().add(WeatherLoadEvent(city: city)),
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
