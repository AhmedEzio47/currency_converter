import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_package/network_layer.dart';

/// Base class for all the exceptions in the app.
sealed class AppException implements Exception {
  const AppException();

  /// Used to identify the error and for localizing the error message to
  /// be shown to the user.
  String get errorKey;

  String getLocalizedMessage(BuildContext context);

  /// Maps [Exception] to [AppException] to be handled by the UI layer.
  static AppException fromException(
    Object exception, [
    StackTrace? stackTrace,
  ]) {
    return exception is NetworkException
        ? _fromNetworkException(exception)
        : const AppUnexpectedException();
  }

  static AppException _fromNetworkException(NetworkException exception) {
    return switch (exception) {
      ServerException() => AppServerException.fromStatusCode(
        exception.statusCode,
        message: exception.message,
        errorCode: exception.errorCode,
      ),
      UnexpectedException() => const AppUnexpectedException(),
      NoInternetException() => const AppNoInternetException(),
    };
  }
}

extension AppExceptionExt on Object {
  Either<AppException, T> toAppException<T>() =>
      Left<AppException, T>(AppException.fromException(this));
}

/// When unexpected error occurs in the app
class AppUnexpectedException extends AppException {
  const AppUnexpectedException();

  @override
  String get errorKey => 'unknownException';

  @override
  String getLocalizedMessage(BuildContext context) => 'unknownException';
}

class AppInvalidInputException extends AppException {
  const AppInvalidInputException(this.message);

  final String message;

  @override
  String get errorKey => 'invalidInput';

  @override
  String getLocalizedMessage(BuildContext context) => message;
}

/// When there is issue connecting to the server and server returned a message.
sealed class AppServerException extends AppException {
  const AppServerException({this.message, this.errorCode, this.statusCode});

  final String? message;
  final String? errorCode;
  final int? statusCode;

  factory AppServerException.fromStatusCode(
    int? statusCode, {
    String? message,
    String? errorCode,
  }) {
    return switch (statusCode) {
      401 => UnauthorizedAppServerException(
        errorCode: errorCode,
        message: message,
        statusCode: statusCode,
      ),
      _ => DefaultAppServerException(
        errorCode: errorCode,
        message: message,
        statusCode: statusCode,
      ),
    };
  }
}

final class DefaultAppServerException extends AppServerException {
  const DefaultAppServerException({
    super.message,
    super.errorCode,
    super.statusCode,
  });

  @override
  String get errorKey => errorCode ?? message ?? 'serverError';

  @override
  String getLocalizedMessage(BuildContext context) => message ?? 'serverError';
}

final class UnauthorizedAppServerException extends AppServerException {
  const UnauthorizedAppServerException({
    super.message,
    super.errorCode,
    super.statusCode,
  });

  @override
  String get errorKey => 'unauthorizedError';

  @override
  String getLocalizedMessage(BuildContext context) => 'unauthorizedError';
}

/// When there is no internet connection
final class AppNoInternetException extends AppException {
  const AppNoInternetException();

  @override
  String get errorKey => 'connectionErrorMessage';

  @override
  String getLocalizedMessage(BuildContext context) => 'connectionErrorMessage';
}

/// When there is issue reading from file
final class AppReadFileException extends AppException {
  const AppReadFileException();

  @override
  String get errorKey => 'cacheException';

  @override
  String getLocalizedMessage(BuildContext context) => 'cacheException';
}

/// When there is issue reading/writing to cache storage.
final class AppCacheException extends AppException {
  const AppCacheException();

  @override
  String get errorKey => 'cacheException';

  @override
  String getLocalizedMessage(BuildContext context) => 'cacheException';
}
