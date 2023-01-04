import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_event.dart';
import 'package:klep_weather/weather_details/bloc/weather_details_state.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherDetailsBloc(
      {required WeatherRepository weatherRepository, required int weatherId})
      : _weatherRepository = weatherRepository,
        _weatherId = weatherId,
        //todo contst
        super(WeatherDetailsState()) {
    //todo add states
  }

  final WeatherRepository _weatherRepository;
  final int _weatherId;
}
