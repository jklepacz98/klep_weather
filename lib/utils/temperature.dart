class Temperature {
  Temperature({required kelvin}) : _kelvin = kelvin;
  final double _kelvin;

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  String toStringAsKelvin() => '${kelvin.toStringAsFixed(0)}\u2103';

  String toStringAsCelsius() => '${celsius.toStringAsFixed(0)}\u2103';

  String toStringAsFahrenheit() => '${fahrenheit.toStringAsFixed(0)}\u2103';
}
