import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_list_bloc.dart';
import 'package:klep_weather/main/bloc/main_bloc.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/settings/bloc/settings_bloc.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_list/bloc/weather_list_bloc.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.I;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => WeatherRepository(
      weatherRemote: WeatherRemote(restClient: getIt()),
      weatherLocal: WeatherLocal(database: getIt()),
      languagePreferences: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => ForecastRepository(
      forecastRemote: ForecastRemote(restClient: getIt()),
      forecastLocal: ForecastLocal(database: getIt()),
      languagePreferences: getIt(),
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
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(
      () => LanguagePreferences(sharedPreferences: getIt()));
  getIt.registerFactory(() => SettingsBloc(languagePreferences: getIt()));
  getIt.registerFactory(() => MainBloc(languagePreferences: getIt()));
  getIt.registerLazySingleton(() => RestClient(getIt()));
  //todo Do I need to set headers in baseOptions for Dio?
  getIt.registerLazySingleton(() => Dio());
  // getIt.registerLazySingleton(() => Dio()..interceptors.add(PrettyDioLogger()));
  getIt.registerLazySingleton(() => AppDatabase());
}
