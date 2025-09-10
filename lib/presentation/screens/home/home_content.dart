import 'package:currency_converter/presentation/screens/coverter/widgets/conversion_form.dart';
import 'package:currency_converter/presentation/screens/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/screens/currencies/widgets/currencies_list.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConversionForm(),
                Divider(height: 64),
                Expanded(
                  child: BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
                    onSuccess: (context, state) {
                      return CurrenciesList(
                        currencies: state.currencies?.currencies ?? [],
                      );
                    },
                    onLoading: (_, _) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
