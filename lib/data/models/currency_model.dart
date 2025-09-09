import 'package:currency_converter/main.dart';
import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  const CurrencyModel({this.currencyCode, this.name});

  final String? currencyCode;
  final String? name;

  Future<String> get flag async {
    final List<dynamic>? codes = countryCodesMap[currencyCode];
    if (codes != null && codes.isNotEmpty) {
      return 'https://flagcdn.com/20x15/${codes.first.toString().toLowerCase()}.png';
    }
    // Return a default/placeholder flag or throw an error if currencyCode is not found
    // or if codes list is empty. For now, let's throw an error.
    throw Exception(
      'Country code not found or invalid for currency: $currencyCode',
    );
  }

  @override
  List<Object?> get props => [currencyCode];
}
