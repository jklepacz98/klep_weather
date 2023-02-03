class Result<T> {
  final bool? _isSuccess;
  final T? _value;
  final String? _failReason;

  Result._({bool? isSuccess, T? value, String? failReason})
      : _isSuccess = isSuccess,
        _value = value,
        _failReason = failReason;

  factory Result.success(T value) {
    return Result._(isSuccess: true, value: value, failReason: null);
  }

  factory Result.failure(String failReason) {
    return Result._(isSuccess: false, value: null, failReason: failReason);
  }

  bool get isSuccess => _isSuccess == true;

  bool get isFailure => _isSuccess == false;

  T? get value => _value;

  String? get failReason => _failReason;

  K when<K>(
      {required K Function(T?) success, required K Function(String?) failure}) {
    if (_isSuccess == true) {
      return success(_value);
    }
    return failure(_failReason);
  }

  Result<K> map<K>(K Function(T?) mapper) {
    if (_isSuccess == true) {
      return Result<K>.success(mapper(_value));
    } else {
      return Result<K>.failure(_failReason ?? '');
    }
  }
}
