import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/screens/currencies/bloc/currencies_bloc.dart';

void injectBlocs() {
  di.registerFactory<CurrenciesBloc>(() => CurrenciesBloc(di()));
}
