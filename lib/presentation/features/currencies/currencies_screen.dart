import 'package:currency_converter/di/di.dart';
import 'package:currency_converter/presentation/features/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/features/currencies/widgets/currencies_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrenciesScreen extends StatelessWidget {
  const CurrenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CurrenciesBloc>()..add(const CurrenciesFetched()),
      child: CurrenciesContent(),
    );
  }
}
