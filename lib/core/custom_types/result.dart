import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:dartz/dartz.dart';

typedef Result<T> = Future<Either<AppException, T>>;
