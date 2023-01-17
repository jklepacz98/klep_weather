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
        title: const Text('KlepWeather'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.blue[600]!,
              Colors.blue[400]!,
              Colors.indigo[200]!,
            ],
          ),
        ),
        child: SafeArea(
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
