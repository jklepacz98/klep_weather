import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:klep_weather/constants.dart';
import 'package:klep_weather/forecast/model/forecast_list_model.dart';
import 'package:klep_weather/weather/model/weather_model.dart';
import 'package:klep_weather/weather/model/weather_models.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.openWeatherApiBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/data/2.5/weather')
  Future<WeatherModel> getWeatherByCity({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') required String language,
    @Query('q') required String city,
  });

  @GET('/data/2.5/weather')
  Future<WeatherModel> getWeatherById({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') required String language,
    @Query('id') required int id,
  });

  @GET('/data/2.5/group')
  Future<WeatherModels> getWeathersByIds({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') required String language,
    @Query('id') required List<int> ids,
  });

  @GET('/data/2.5/forecast')
  Future<ForecastListModel> getForecastById({
    @Query('appid') String appid = Constants.openWeatherApiKey,
    @Query('lang') required String language,
    @Query('id') required int id,
  });
}
