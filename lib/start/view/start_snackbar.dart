import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '../bloc/start_bloc.dart';
import '../bloc/start_state.dart';

class StartSnackBar extends StatelessWidget {
  const StartSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StartBloc>(),
      child: BlocListener<StartBloc, StartState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state.status == WeatherStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Success'),
              ),
            );
          } else if (state.status == WeatherStatus.failure) {
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
