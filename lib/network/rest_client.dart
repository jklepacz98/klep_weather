import 'package:dio/dio.dart';
import 'package:klep_weather/city_forecast/model/city_forecast_list_remote_model.dart';
import 'package:klep_weather/constants.dart';
import 'package:retrofit/retrofit.dart';

import '../weather/model/weather_group_remote_model.dart';
import '../weather/model/weather_remote_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.openWeatherApiBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/data/2.5/weather')
  Future<WeatherRemoteModel> getWeatherByCity({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') String language = Constants.defaultLanguage,
    @Query('q') required String city,
  });

  @GET('/data/2.5/weather')
  Future<WeatherRemoteModel> getWeatherById({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') String language = Constants.defaultLanguage,
    @Query('id') required int id,
  });

  @GET('/data/2.5/group')
  Future<WeatherGroupRemoteModel> getWeathersByIds({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') String language = Constants.defaultLanguage,
    @Query('id') required List<int> ids,
  });

  @GET('/data/2.5/forecast')
  Future<CityForecastRemoteModel> getForecastById({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') String language = Constants.defaultLanguage,
    @Query('id') required int id,
  });
}
