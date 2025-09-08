part of 'exchange_rates_bloc.dart';

final class ExchangeRatesState extends BaseState {
  const ExchangeRatesState({
    super.status = Status.initial,
    super.failure,
    this.rates,
    this.baseCurrency,
    this.targetCurrency,
  });

  final List<ExchangeRateEntity>? rates;
  final String? baseCurrency;
  final String? targetCurrency;
}
