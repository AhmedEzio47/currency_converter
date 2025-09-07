import 'package:currency_converter/core/custom_types/result.dart';

abstract interface class UseCase<T, P> {
  Result<T> call(P params);
}

class NoParams {
  const NoParams();
}
