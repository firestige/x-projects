import 'package:flutter/widgets.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverterPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Currency Converter Page'),
    );
  }
}