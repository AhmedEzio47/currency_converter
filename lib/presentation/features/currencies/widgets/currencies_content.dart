import 'package:currency_converter/presentation/features/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';

import 'currencies_list.dart';

class CurrenciesContent extends StatelessWidget {
  const CurrenciesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currencies')),
      body: Center(
        child: BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
          onSuccess: (_, state) =>
              CurrenciesList(currencies: state.currencies?.currencies ?? []),
        ),
      ),
    );
  }
}
