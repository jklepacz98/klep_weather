extension WeatherIconUrlConverter on String {
  String toIconUrl() => 'https://openweathermap.org/img/wn/$this@2x.png';
}
