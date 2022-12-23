import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:klep_weather/constants.dart';
import 'package:klep_weather/weather/model/weather_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.openWeatherApiBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/data/2.5/weather")
  Future<WeatherModel> getWeatherByCity({
    @Query("appid") String appid = Constants.openWeatherApiKey,
    //todo remove 'London'
    @Query("q") String q = 'London',
  });
}
