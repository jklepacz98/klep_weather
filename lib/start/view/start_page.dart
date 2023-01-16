import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/start/view/start_snackbar.dart';
import 'package:klep_weather/start/view/weather_list.dart';
import 'package:klep_weather/start/view/weather_search_field.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: const [0.1, 0.2, 0.6, 0.9],
              colors: [
                //todo get rid of exclamation mark?
                Colors.blue[800]!,
                Colors.blue[600]!,
                Colors.blue[400]!,
                Colors.indigo[200]!,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: const [
                WeatherSearchField(),
                StartSnackBar(),
                WeatherList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
