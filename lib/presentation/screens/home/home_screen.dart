import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/features/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di<CurrenciesBloc>()..add(CurrenciesFetched()),
        ),
        BlocProvider(
          create: (context) =>
              di<ExchangeRatesBloc>()
                ..add(ExchangeRatesForTodayFetched(baseCurrency: 'USD')),
        ),
      ],
      child: HomeContent(),
    );
  }
}
