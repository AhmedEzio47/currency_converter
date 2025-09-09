import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:equatable/equatable.dart';

base class BaseState extends Equatable {
  const BaseState({required this.status, this.failure});

  final Status status;
  final AppException? failure;

  @override
  List<Object?> get props => [status, failure];
}
