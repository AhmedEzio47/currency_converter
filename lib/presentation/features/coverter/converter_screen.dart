import 'package:currency_converter/core/extensions/num_formatting.dart';
import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/features/coverter/widgets/conversion_form.dart';
import 'package:currency_converter/presentation/features/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/widgets/app_snack_bar.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/converter_bloc.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di<CurrenciesBloc>()..add(CurrenciesFetched()),
        ),
        BlocProvider(
          create: (_) =>
              di<ExchangeRatesBloc>()
                ..add(ExchangeRatesForTodayFetched(baseCurrency: 'USD')),
        ),
        BlocProvider(create: (_) => di<ConverterBloc>()),
      ],
      child: const ConverterContent(),
    );
  }
}

class ConverterContent extends StatefulWidget {
  const ConverterContent({super.key});

  @override
  State<ConverterContent> createState() => _ConverterContentState();
}

class _ConverterContentState extends State<ConverterContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            ConversionForm(),

            // if (_toCurrency != null)
            //   BaseBlocConsumer<ExchangeRatesBloc, ExchangeRatesState>(
            //     onSuccess: (context, state) {
            //       return Text(
            //         'Today’s rate: 1 ${state.baseCurrency} = ${state.todayRate(_toCurrency!)?.toMaxTwoDecimals()} $_toCurrency',
            //       );
            //     },
            //   ),
            const SizedBox(height: 16),

            /// Show conversion result
            BaseBlocConsumer<ConverterBloc, ConverterState>(
              listener: (context, state) {
                if (state.status == Status.failure) {
                  AppSnackBar.show(
                    snackBarType: SnackBarTypes.error,
                    context: context,
                    message:
                        state.failure?.getLocalizedMessage(context) ??
                        'Conversion error',
                  );
                }
              },
              onSuccess: (context, state) {
                return Text(
                  '${state.amount} ${state.from} = ${state.result?.toMaxTwoDecimals()} ${state.to}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
