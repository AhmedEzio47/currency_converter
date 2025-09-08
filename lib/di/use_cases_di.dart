import 'package:currency_converter/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/domain/use_cases/get_exchange_rates_use_case.dart';

import 'di.dart';

void injectUseCases() {
  di.registerFactory<GetCurrenciesUseCase>(() => GetCurrenciesUseCase(di()));
  di.registerFactory<GetExchangeRatesUseCase>(
    () => GetExchangeRatesUseCase(di()),
  );
}
