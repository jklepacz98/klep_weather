import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:klep_weather/di/di.config.dart';
import 'package:klep_weather/network/rest_client.dart';
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
