import 'package:currency_converter/presentation/screens/currencies/currencies_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CurrenciesScreen()),
                );
              },
              child: const Text("Currencies"),
            ),
          ],
        ),
      ),
    );
  }
}
