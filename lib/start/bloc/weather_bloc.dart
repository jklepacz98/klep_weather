import 'package:bloc/bloc.dart';
import 'package:klep_weather/start/bloc/weather_event.dart';
import 'package:klep_weather/start/bloc/weather_state.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        //todo const?
        super(const WeatherState()) {
    on<WeatherValueChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
      //todo
      add(WeatherGet());
    });
    on<WeatherListChanged>((event, emit) {
      emit(state.copyWith(weathers: event.weathers));
    });
    on<WeatherLoad>((event, emit) {
      _handleLoadWeatherEvent(event.city);
    });
    on<WeatherGet>((event, emit) {
      _handleGetWeatherEvent();
    });
    //todo
    add(WeatherLoad(city: 'Łódź'));
  }

  final WeatherRepository _weatherRepository;

  void _handleLoadWeatherEvent(String city) async {
    final weatherResult = await _weatherRepository.loadWeather(city);
    if (weatherResult.isSuccess) {
      final city = weatherResult.value!.name;
      add(WeatherValueChanged(city));
    }
  }

  void _handleGetWeatherEvent() async {
    final weathersResult = await _weatherRepository.getWeathers();
    if (weathersResult.isSuccess) {
      final weathers = weathersResult.value!;
      add(WeatherListChanged(weathers: weathers));
    }
  }
}
