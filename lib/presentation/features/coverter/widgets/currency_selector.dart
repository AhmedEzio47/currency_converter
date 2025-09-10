import 'package:currency_converter/data/models/currency_model.dart';
import 'package:currency_converter/presentation/widgets/country_flag.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({
    super.key,
    required this.currencies,
    this.initialValue,
    this.onChanged,
  });

  final String? initialValue;
  final List<CurrencyModel> currencies;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF151425),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      isExpanded: false,
      initialValue: initialValue,
      items: currencies
          .map(
            (c) => DropdownMenuItem(
              value: c.currencyCode,
              child: Row(
                spacing: 8,
                children: [
                  CountryFlag(flag: c.flag, size: 30),
                  Text('${c.currencyCode}'),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
