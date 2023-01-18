import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/start/bloc/start_bloc.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(database: getIt()),
    ),
  );
  getIt.registerLazySingleton(
    () => StartBloc(
      weatherRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => RestClient(getIt()));
  //todo Do I need to set headers in baseOptions for Dio?
  getIt.registerLazySingleton(() => Dio());
  // getIt.registerLazySingleton(() => Dio()..interceptors.add(PrettyDioLogger()));
  getIt.registerLazySingleton(() => AppDatabase());
}
