import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/di/di.dart' as di;
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/main/bloc/main_bloc.dart';
import 'package:klep_weather/start/view/start_page.dart';

void main() async {
  //todo
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainBloc>(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.orange.shade500,
                onPrimary: Colors.white,
                secondary: Colors.blue,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.green,
                background: Colors.deepPurple.shade800,
                onBackground: Colors.pink,
                surface: Colors.blueGrey.shade800,
                onSurface: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.blueGrey.shade900,
              listTileTheme: ListTileThemeData(
                tileColor: Colors.blueGrey.shade800,
              ),
              drawerTheme: DrawerThemeData(
                backgroundColor: Colors.blueGrey.shade900,
              ),
              cardTheme: CardTheme(
                color: Colors.blueGrey.shade800,
              ),
            ),
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const StartPage(),
          );
        },
      ),
    );
  }
}
