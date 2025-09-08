import 'package:currency_converter/core/custom_types/result.dart';
import 'package:currency_converter/data/models/currencies_model.dart';

import '../../models/exchange_rates_model.dart';

abstract interface class CurrencyRepo {
  Result<CurrenciesModel> getCurrencies();

  Result<ExchangeRatesModel> getExchangeRates({
    required String base,
    required String date,
  });
}
