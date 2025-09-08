import 'package:currency_converter/data/models/currency_model.dart';

import '../../core/custom_types/json.dart';

class CurrenciesModel {
  const CurrenciesModel(this.currencies);

  final List<CurrencyModel> currencies;

  factory CurrenciesModel.fromJson(JSON json) {
    var currencies = <CurrencyModel>[];
    for (final key in json.keys) {
      currencies.add(CurrencyModel(currencyCode: key, name: json[key]));
    }
    return CurrenciesModel(currencies);
  }
}
