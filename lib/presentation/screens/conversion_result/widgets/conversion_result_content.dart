import 'package:currency_converter/core/extensions/num_formatting.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/widgets/exchange_rates_chart.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';

import '../conversion_result_args.dart';

class ConversionResultContent extends StatelessWidget {
  const ConversionResultContent({super.key, required this.args});

  final ConversionResultArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '1 ${args.fromCurrency} equals ${args.rate.toMaxTwoDecimals()} ${args.toCurrency}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  args.result.toMaxTwoDecimals(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${args.toCurrency}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 40),
            BaseBlocConsumer<ExchangeRatesBloc, ExchangeRatesState>(
              onSuccess: (context, state) =>
                  ExchangeRatesChart(exchangeRates: state.rates ?? []),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Convert Again'),
          ),
        ),
      ),
    );
  }
}
