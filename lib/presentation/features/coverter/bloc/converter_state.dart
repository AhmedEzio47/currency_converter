part of 'converter_bloc.dart';

final class ConverterState extends BaseState {
  const ConverterState({
    super.status = Status.initial,
    super.failure,
    this.from,
    this.to,
    this.amount,
    this.result,
  });

  final String? from;
  final String? to;
  final num? amount;
  final num? result;

  @override
  List<Object?> get props => super.props..addAll([from, to, amount, result]);
}
