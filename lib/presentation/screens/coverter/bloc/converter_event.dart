part of 'converter_bloc.dart';

sealed class ConverterEvent {
  const ConverterEvent();
}

final class ConversionSubmitted extends ConverterEvent {
  const ConversionSubmitted({
    required this.from,
    required this.to,
    required this.amount,
    required this.rate,
  }) : assert(amount > 0, 'Amount must be greater than zero');

  final String from;
  final String to;
  final num amount;
  final num rate;
}

final class ConversionReset extends ConverterEvent {
  const ConversionReset();
}
