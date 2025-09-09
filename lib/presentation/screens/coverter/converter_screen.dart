import 'package:currency_converter/core/extensions/num_formatter.dart';
import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/screens/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/screens/exchange_rates/bloc/exchange_rates_bloc.dart';
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
  final String _fromCurrency = 'USD';
  String? _toCurrency;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
              onSuccess: (context, state) {
                return Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'From'),
                      initialValue: _fromCurrency,
                      items: state.currencies?.currencies
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.currencyCode,
                              child: SizedBox(
                                width: 300,
                                child: Text('${c.currencyCode} - ${c.name}'),
                              ),
                            ),
                          )
                          .toList(),

                      onChanged: null,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'To'),
                      initialValue: _toCurrency,
                      items: state.currencies?.currencies
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.currencyCode,
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  '${c.currencyCode} - ${c.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() => _toCurrency = val);
                        _amountController.clear();
                        context.read<ConverterBloc>().add(
                          const ConversionReset(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),

            // Amount input
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Convert button
            BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
              builder: (context, state) {
                if (state.status == Status.success) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_toCurrency != null &&
                          _amountController.text.isNotEmpty) {
                        final amount =
                            num.tryParse(_amountController.text) ?? 0;
                        context.read<ConverterBloc>().add(
                          ConversionSubmitted(
                            from: _fromCurrency,
                            to: _toCurrency!,
                            amount: amount,
                            rate: state.todayRate(_toCurrency!) ?? 0,
                          ),
                        );
                      }
                    },
                    child: const Text('Convert'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            const SizedBox(height: 24),

            if (_toCurrency != null)
              BaseBlocConsumer<ExchangeRatesBloc, ExchangeRatesState>(
                onSuccess: (context, state) {
                  return Text(
                    'Today’s rate: 1 ${state.baseCurrency} = ${state.todayRate(_toCurrency!)?.toMaxTwoDecimals()} $_toCurrency',
                  );
                },
              ),

            const SizedBox(height: 16),

            // Show conversion result
            BaseBlocConsumer<ConverterBloc, ConverterState>(
              onSuccess: (context, state) {
                return Text(
                  '${state.amount} ${state.from} = ${state.converted?.toMaxTwoDecimals()} ${state.to}',
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
