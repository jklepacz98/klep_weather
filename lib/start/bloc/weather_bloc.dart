import 'package:bloc/bloc.dart';
import 'package:klep_weather/start/bloc/weather_state.dart';
import 'package:klep_weather/weather/repository/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        //todo const?
        super(const WeatherState()) {
    on<WeatherValueChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<WeatherGet>((event, emit) {
      _handleGetWeatherEvent();
    });
    add(WeatherGet());
  }

  final WeatherRepository _weatherRepository;

  void _handleGetWeatherEvent() async {
    print("something1");
    final weatherResult = await _weatherRepository.loadWeather();
    print("something2");
    if (weatherResult.isSuccess) {
      print("something3");
      final city = weatherResult.value!.name;
      add(WeatherValueChanged(city));
    }
  }
}
