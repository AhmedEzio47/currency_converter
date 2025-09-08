class ExchangeRateModel {
  const ExchangeRateModel({this.targetCurrency, this.rate, this.timestamp});

  final String? targetCurrency;
  final num? rate;
  final int? timestamp;
}
