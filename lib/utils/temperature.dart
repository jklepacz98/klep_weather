class Temperature {
  Temperature({required kelvin}) : _kelvin = kelvin;
  final double _kelvin;

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;
}
