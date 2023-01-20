import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/start/bloc/start_bloc.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(database: getIt()),
    ),
  );
  getIt.registerLazySingleton(
    () => ForecastRepository(
      forecastRemote: ForecastRemote(restClient: getIt()),
      forecastLocal: ForecastLocal(database: getIt()),
    ),
  );
  getIt.registerLazySingleton(
    () => StartBloc(
      weatherRepository: getIt(),
    ),
  );
  getIt.registerFactoryParam<WeatherDetailsBloc, int, void>(
    (cityId, _) => WeatherDetailsBloc(
      weatherRepository: getIt(),
      forecastRepository: getIt(),
      cityId: cityId,
    ),
  );
  getIt.registerLazySingleton(() => RestClient(getIt()));
  //todo Do I need to set headers in baseOptions for Dio?
  getIt.registerLazySingleton(() => Dio());
  // getIt.registerLazySingleton(() => Dio()..interceptors.add(PrettyDioLogger()));
  getIt.registerLazySingleton(() => AppDatabase());
}
