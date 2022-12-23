import 'package:get_it/get_it.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(),
    ),
  );
  getIt.registerLazySingleton(() => RestClient(getIt()));
  //todo Do I need to set headers in baseOptions for Dio?
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => AppDatabase());
}
