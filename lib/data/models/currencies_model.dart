import 'package:currency_converter/data/models/currency_model.dart';
import 'package:equatable/equatable.dart';

import '../../core/custom_types/json.dart';

class CurrenciesModel extends Equatable {
  const CurrenciesModel(this.currencies);

  final List<CurrencyModel> currencies;

  factory CurrenciesModel.fromJson(JSON json) {
    var currencies = <CurrencyModel>[];
    for (final key in json.keys) {
      currencies.add(CurrencyModel(currencyCode: key, name: json[key]));
    }
    return CurrenciesModel(currencies);
  }

  @override
  List<Object?> get props => [currencies];
}
