import 'dart:math';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  static Color random() {
    final Random random = Random();
    return Color.fromARGB(
      255, // fully opaque
      random.nextInt(256), // red (0–255)
      random.nextInt(256), // green (0–255)
      random.nextInt(256), // blue (0–255)
    );
  }
}
