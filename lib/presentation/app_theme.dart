import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final Color primaryColor = Colors.deepPurpleAccent;

    return ThemeData(
      scaffoldBackgroundColor: Color(0xFF0A0B14),
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
