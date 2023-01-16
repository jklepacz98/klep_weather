extension WeatherIconUrlConverter on String {
  toIconUrl() => "https://openweathermap.org/img/wn/$this@2x.png";
}
