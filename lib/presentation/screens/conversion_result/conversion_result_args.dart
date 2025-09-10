class ConversionResultArgs {
  final String fromCurrency;
  final String toCurrency;
  final num rate;
  final num result;

  ConversionResultArgs({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.result,
  });
}
