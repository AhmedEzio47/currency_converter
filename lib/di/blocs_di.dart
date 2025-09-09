import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/screens/coverter/bloc/converter_bloc.dart';
import 'package:currency_converter/presentation/screens/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/screens/exchange_rates/bloc/exchange_rates_bloc.dart';

void injectBlocs() {
  di.registerFactory<CurrenciesBloc>(() => CurrenciesBloc(di()));
  di.registerFactory<ExchangeRatesBloc>(
    () => ExchangeRatesBloc(
      getExchangeRatesUseCase: di(),
      getTodayExchangeRateUseCase: di(),
    ),
  );
  di.registerFactory<ConverterBloc>(() => ConverterBloc());
}
