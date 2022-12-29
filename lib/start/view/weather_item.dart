import 'package:flutter/cupertino.dart';

import '../../database/database.dart';

class WeatherItem extends StatelessWidget {
  WeatherItem({required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGreen,
      child: Text(weather.name.toString()),
    );
  }
}
