// import 'package:intl/intl.dart';

extension NumFormatting on num {
  String toMaxTwoDecimals() {
    String str = toStringAsFixed(2);
    // Remove trailing zeros and dot if unnecessary
    str = str.replaceFirst(RegExp(r'\.?0+$'), '');

    // Split integer and decimal parts
    final parts = str.split('.');
    String intPart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Insert commas every 3 digits
    final buffer = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      int positionFromEnd = intPart.length - i;
      buffer.write(intPart[i]);
      if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }

    return buffer.toString() + decimalPart;
  }
}
