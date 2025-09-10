import 'package:currency_converter/main.dart';
import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  const CurrencyModel({this.currencyCode, this.name});

  final String? currencyCode;
  final String? name;

  String get flag {
    final List<dynamic>? codes = countryCodesMap[currencyCode];
    if (codes != null && codes.isNotEmpty) {
      return 'https://flagcdn.com/w80/${codes.first.toString().toLowerCase()}.png';
    }
    return 'https://flagcdn.com/w80/un.png'; // Unknown flag
  }

  @override
  List<Object?> get props => [currencyCode];
}
