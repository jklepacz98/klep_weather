import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/start/bloc/weather_bloc.dart';
import 'package:klep_weather/weather/repository/local/weather_local.dart';
import 'package:klep_weather/weather/repository/remote/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

import '../weather/repository/local/weather_model_local.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(database: getIt()),
    ),
  );
  getIt.registerLazySingleton(
    () => WeatherBloc(
      weatherRepository: getIt(),
    ),
  );
  getIt.registerLazySingletonAsync(() => Isar.open([WeatherModelLocalSchema]));
  getIt.registerLazySingleton(() => RestClient(getIt()));
  //todo Do I need to set headers in baseOptions for Dio?
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => AppDatabase());
}
