class ExchangeRatesParams {
  const ExchangeRatesParams({
    required this.baseCurrency,
    required this.targetCurrency,
  });

  final String baseCurrency;
  final String targetCurrency;
}
