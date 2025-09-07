import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/currencies/bloc/currencies_bloc.dart';

void injectBlocs() {
  di.registerFactory<CurrenciesBloc>(() => CurrenciesBloc(di()));
}
