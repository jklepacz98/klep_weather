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
        title: const Text('KlepWeather'),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            WeatherSearchField(),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            StartSnackBar(),
            WeatherList(),
          ],
        ),
      ),
    );
  }
}
