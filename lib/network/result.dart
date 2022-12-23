import 'package:klep_weather/network/result_failure.dart';

class Result<T> {
  final bool? _isSuccess;
  final T? _value;
  final ResultFailure? _failure;

  Result._({bool? isSuccess, T? value, ResultFailure? failure})
      : _isSuccess = isSuccess,
        _value = value,
        _failure = failure;

  factory Result.success(T value){
    return Result._(isSuccess: true, value: value, failure: null);
  }

  factory Result.failure(String reason, int code) {
    final failure = ResultFailure(reason, code);
    return Result._(isSuccess: false, value: null, failure: failure);
  }

  bool get isSuccess => _isSuccess == true;

  bool get isFailure => _isSuccess == false;

  T? get value => _value;

  ResultFailure? get failure => _failure;

  K when<K>({required K Function(T?) success,
    required K Function(ResultFailure?) failure}) {
    if (_isSuccess == true) {
      return success(_value);
    }
    return failure(_failure);
  }

  Result<K> map<K>(K Function(T?) mapper) {
    if(_isSuccess == true) {
      return Result<K>.success(mapper(_value));
    } else {
      return Result<K>.failure(_failure?.reason ?? "", _failure?.code ?? 0);
    }
  }
}
