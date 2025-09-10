import 'dart:convert';

import 'package:currency_converter/core/custom_types/json.dart';
import 'package:currency_converter/presentation/app_theme.dart';
import 'package:currency_converter/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'di/di.dart';

JSON countryCodesMap = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  final String jsonString = await rootBundle.loadString(
    'assets/currency_country.json',
  );
  countryCodesMap = jsonDecode(jsonString);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency converter app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
