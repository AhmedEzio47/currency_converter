import 'package:currency_converter/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/domain/use_cases/get_last_week_exchange_rates_use_case.dart';
import 'package:currency_converter/domain/use_cases/get_today_exchange_rate_use_case.dart';

import 'di.dart';

void injectUseCases() {
  di.registerFactory<GetCurrenciesUseCase>(() => GetCurrenciesUseCase(di()));
  di.registerFactory<GetLastWeekExchangeRatesUseCase>(
    () => GetLastWeekExchangeRatesUseCase(di()),
  );
  di.registerFactory<GetTodayExchangeRateUseCase>(
    () => GetTodayExchangeRateUseCase(di()),
  );
}
