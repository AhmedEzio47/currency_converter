import 'package:equatable/equatable.dart';

class ExchangeRateModel extends Equatable {
  const ExchangeRateModel({this.targetCurrency, this.rate, this.timestamp});

  final String? targetCurrency;
  final num? rate;
  final int? timestamp;

  @override
  List<Object?> get props => [targetCurrency, rate, timestamp];
}
