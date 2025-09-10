import 'package:currency_converter/data/models/currency_model.dart';
import 'package:flutter/material.dart';

import 'currency_item.dart';

class CurrenciesList extends StatelessWidget {
  const CurrenciesList({super.key, required this.currencies});

  final List<CurrencyModel> currencies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, _) => const SizedBox(height: 5),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CurrencyItem(currency: currencies[index]),
      ),
      itemCount: currencies.length,
    );
  }
}
