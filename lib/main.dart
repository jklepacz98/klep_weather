import 'package:flutter/material.dart';
//todo
import 'package:klep_weather/di/di.dart' as di;
import 'package:klep_weather/start/view/start_page.dart';

void main() async {
  //todo
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
