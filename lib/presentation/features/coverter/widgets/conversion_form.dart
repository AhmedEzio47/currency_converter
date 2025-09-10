import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/features/coverter/bloc/converter_bloc.dart';
import 'package:currency_converter/presentation/features/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/features/exchange_rates/bloc/exchange_rates_bloc.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'currency_selector.dart';

class ConversionForm extends HookWidget {
  const ConversionForm({super.key});

  final String _fromCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    final toCurrency = useState<String?>(null);
    final TextEditingController amountController = useTextEditingController();

    return Column(
      spacing: 16,
      children: [
        BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
          onSuccess: (context, state) {
            return Column(
              spacing: 16,
              children: [
                TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF151425),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 700.ms)
                    .slide(begin: const Offset(-1, 0)),

                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 140,
                          child: CurrencySelector(
                            currencies: state.currencies?.currencies ?? [],
                            initialValue: _fromCurrency,
                            onChanged: null,
                          ),
                        ),
                        const Icon(Icons.arrow_forward, size: 30),
                        SizedBox(
                          width: 140,
                          child: CurrencySelector(
                            currencies: state.currencies?.currencies ?? [],
                            initialValue: toCurrency.value,
                            onChanged: (value) {
                              toCurrency.value = value;
                            },
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 700.ms, delay: 500.ms)
                    .slide(begin: const Offset(1, 0)),
              ],
            );
          },
        ),

        /// Convert button
        BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
          builder: (context, state) {
            if (state.status == Status.success) {
              return ElevatedButton(
                onPressed: () {
                  if (toCurrency.value != null &&
                      amountController.text.isNotEmpty) {
                    final amount = num.tryParse(amountController.text) ?? 0;
                    context.read<ConverterBloc>().add(
                      ConversionSubmitted(
                        from: _fromCurrency,
                        to: toCurrency.value!,
                        amount: amount,
                        rate: state.todayRate(toCurrency.value!) ?? 0,
                      ),
                    );
                  }
                },
                child: const Text('Convert'),
              ).animate().fadeIn().scale(duration: 500.ms, delay: 1.2.seconds);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
