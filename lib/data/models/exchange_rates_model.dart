import 'package:currency_converter/core/custom_types/json.dart';
import 'package:equatable/equatable.dart';

import 'exchange_rate_model.dart';

class ExchangeRatesModel extends Equatable {
  const ExchangeRatesModel({this.rates, this.baseCurrency});

  final List<ExchangeRateModel>? rates;
  final String? baseCurrency;

  factory ExchangeRatesModel.fromJson(JSON json) {
    final ratesJson = json['rates'] as JSON;
    var rates = <ExchangeRateModel>[];
    for (final key in ratesJson.keys) {
      rates.add(
        ExchangeRateModel(
          targetCurrency: key,
          rate: ratesJson[key],
          timestamp: json['timestamp'],
        ),
      );
    }
    return ExchangeRatesModel(rates: rates, baseCurrency: json['base']);
  }

  @override
  List<Object?> get props => [baseCurrency, rates];
}
