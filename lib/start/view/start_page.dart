import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

class StartPage extends StatelessWidget {
  final _weatherRepository = getIt<WeatherRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo change or remove color
      backgroundColor: Colors.amber,
      body: Center(
          child: FutureBuilder(
        future: _weatherRepository.loadWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.value!.name);
          } else {
            return Text("hehe");
          }
        },
      )),
    );
  }
}
