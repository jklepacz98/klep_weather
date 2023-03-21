import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:klep_weather/database/database.dart';
import 'package:klep_weather/di/di.config.dart';
import 'package:klep_weather/forecast/repository/forecast_local.dart';
import 'package:klep_weather/forecast/repository/forecast_remote.dart';
import 'package:klep_weather/forecast/repository/forecast_repository.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_list_bloc.dart';
import 'package:klep_weather/main/bloc/main_bloc.dart';
import 'package:klep_weather/network/rest_client.dart';
import 'package:klep_weather/shared_preferences/language_preferences.dart';
import 'package:klep_weather/weather/repository/weather_local.dart';
import 'package:klep_weather/weather/repository/weather_remote.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_bloc.dart';
import 'package:klep_weather/weather_list/bloc/weather_list_bloc.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  RestClient get restClient => RestClient(getIt());

  Dio get dio => Dio();
}
