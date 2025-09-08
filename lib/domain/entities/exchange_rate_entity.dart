import 'package:currency_converter/data/models/exchange_rate_model.dart';

class ExchangeRateEntity {
  const ExchangeRateEntity({this.rate, this.dateTime});

  final num? rate;
  final DateTime? dateTime;

  factory ExchangeRateEntity.fromModel(ExchangeRateModel model) =>
      ExchangeRateEntity(
        rate: model.rate,
        dateTime: DateTime.fromMillisecondsSinceEpoch(model.timestamp! * 1000),
      );
}
