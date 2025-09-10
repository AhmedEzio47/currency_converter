part of 'converter_bloc.dart';

final class ConverterState extends BaseState {
  const ConverterState({
    super.status = Status.initial,
    super.failure,
    this.from,
    this.to,
    this.amount,
    this.converted,
  });

  final String? from;
  final String? to;
  final num? amount;
  final num? converted;
}
