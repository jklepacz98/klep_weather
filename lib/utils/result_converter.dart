import 'package:klep_weather/network/result.dart';

extension ResultConverter<T> on List<Result<T>> {
  Result<List<T>> toSingleResult() {
    final failures = this.where((result) => result.isFailure);
    final failReasons = failures.map((failure) => failure.failReason);
    if (failures.isEmpty) {
      return Result.success(this.map((result) => result.value!).toList());
    } else {
      return Result.failure(failReasons.join('\n'));
    }
  }
}
