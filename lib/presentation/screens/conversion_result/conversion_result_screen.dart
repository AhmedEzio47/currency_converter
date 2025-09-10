import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/screens/conversion_result/widgets/conversion_result_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'conversion_result_args.dart';

class ConversionResultScreen extends StatelessWidget {
  const ConversionResultScreen({super.key, required this.args});

  final ConversionResultArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<ExchangeRatesBloc>()..add(ExchangeRatesForLastWeekFetched()),
      child: ConversionResultContent(args: args),
    );
  }
}
