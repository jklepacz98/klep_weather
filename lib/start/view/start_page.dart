import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/start/view/start_snackbar_widget.dart';
import 'package:klep_weather/weather_list/view/weather_list_widget.dart';
import 'package:klep_weather/weather_search/view/weather_search_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('KlepWeather'),
        title: Text(AppLocalizations.of(context)!.klepWeather),
        backgroundColor: Colors.blueGrey[800],
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: const [
            WeatherSearchField(),
            StartSnackbarWidget(),
            WeatherListWidget(),
          ],
        ),
      ),
    );
  }
}
