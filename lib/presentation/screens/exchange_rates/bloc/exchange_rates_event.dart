part of 'exchange_rates_bloc.dart';

sealed class ExchangeRatesEvent {
  const ExchangeRatesEvent();
}

final class ExchangeRatesForLastWeekFetched extends ExchangeRatesEvent {
  const ExchangeRatesForLastWeekFetched();
}
