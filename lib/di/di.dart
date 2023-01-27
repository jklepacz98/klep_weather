import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_list_bloc.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_list/bloc/weather_list_bloc.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(
        database: getIt(),
      ),
    ),
  );
  getIt.registerLazySingleton(
    () => ForecastRepository(
      forecastLocal: ForecastLocal(database: getIt()),
    ),
  );
  getIt.registerLazySingleton(
    () => WeatherListBloc(weatherRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => WeatherSearchBloc(weatherRepository: getIt()),
  );
  getIt.registerFactoryParam<WeatherDetailsBloc, int, void>(
    (cityId, _) => WeatherDetailsBloc(
      weatherRepository: getIt(),
      cityId: cityId,
    ),
  );
  getIt.registerFactoryParam<ForecastListBloc, int, void>(
    (cityId, _) => ForecastListBloc(
      forecastRepository: getIt(),
      cityId: cityId,
    ),
  );
  getIt.registerLazySingleton(() => RestClient(getIt()));
  getIt.registerLazySingleton(() => Dio());
  //todo
  // getIt.registerLazySingleton(() => Dio()..interceptors.add(PrettyDioLogger()));
  getIt.registerLazySingleton(() => AppDatabase());
}
