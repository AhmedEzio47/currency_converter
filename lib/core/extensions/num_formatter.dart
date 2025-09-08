extension NumFormatter on num {
  String toMaxTwoDecimals() {
    // Removes trailing zeros after formatting
    return toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');
  }
}
