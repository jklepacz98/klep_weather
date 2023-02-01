import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//todo
import 'package:klep_weather/di/di.dart' as di;
import 'package:klep_weather/main/bloc/main_bloc.dart';
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
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(builder: (context, mainState) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            backgroundColor: Colors.blue,
          ),
          locale: mainState.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const StartPage(),
        );
      }),
    );
  }
}
