import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/presentation/common/status.dart';

base class BaseState {
  const BaseState({required this.status, this.failure});

  final Status status;
  final AppException? failure;
}
