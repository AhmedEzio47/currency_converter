import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/widgets/exchange_rates_chart.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';

class ExchangeRatesContent extends StatelessWidget {
  const ExchangeRatesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exchange Rates"), centerTitle: true),
      body: Center(
        child: BaseBlocConsumer<ExchangeRatesBloc, ExchangeRatesState>(
          onSuccess: (context, state) => Column(
            spacing: 30,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.baseCurrency ?? '',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_right_alt, size: 30),
                  Text(
                    state.targetCurrency ?? '',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExchangeRatesChart(exchangeRates: state.rates ?? []),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
