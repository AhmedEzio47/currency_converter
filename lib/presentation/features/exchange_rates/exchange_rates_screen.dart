import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/exchange_rates_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRatesScreen extends StatelessWidget {
  const ExchangeRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<ExchangeRatesBloc>()..add(ExchangeRatesForLastWeekFetched()),
      child: ExchangeRatesContent(),
    );
  }
}
