import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/data/models/currencies_model.dart';

abstract interface class CurrencyRepo {
  Result<CurrenciesModel> getCurrencies();
}
