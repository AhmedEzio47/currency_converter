import 'package:currency_converter/presentation/common/color_extension.dart';
import 'package:currency_converter/presentation/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:flutter/material.dart';

class CurrenciesContent extends StatelessWidget {
  const CurrenciesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
          onSuccess: (_, state) => ListView.separated(
            separatorBuilder: (_, _) => const SizedBox(height: 5),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leadingAndTrailingTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    color: ColorExtension.random(),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text(state.currencies?.currencies[index].key ?? ''),
                ),
                tileColor: Theme.of(context).cardColor,
                title: Text(state.currencies?.currencies[index].name ?? ''),
              ),
            ),
            itemCount: state.currencies?.currencies.length ?? 0,
          ),
        ),
      ),
    );
  }
}
