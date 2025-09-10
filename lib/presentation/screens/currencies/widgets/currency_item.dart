import 'package:currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/presentation/widgets/country_flag.dart';
import 'package:flutter/material.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem({super.key, required this.currency});

  final CurrencyModel currency;
  final double flagSize = 50;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      leading: CountryFlag(flag: currency.flag, size: flagSize),
      title: Text(
        currency.name ?? '',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        currency.currencyCode ?? '',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
