part of 'exchange_rates_bloc.dart';

sealed class ExchangeRatesEvent {
  const ExchangeRatesEvent();
}

final class ExchangeRatesForLastWeekFetched extends ExchangeRatesEvent {
  const ExchangeRatesForLastWeekFetched({required this.targetCurrency});

  final String targetCurrency;
}

final class ExchangeRatesForTodayFetched extends ExchangeRatesEvent {
  const ExchangeRatesForTodayFetched({required this.baseCurrency});

  final String baseCurrency;
}
