import 'package:flutter/material.dart';
import 'pages/simple_calculator.dart';
import 'pages/scientific_calculator.dart';
import 'pages/currency_converter.dart';
import 'pages/unit_converter.dart';

void main() {
  runApp(MaterialApp(
    title: "Multiplatform Calculator App",
    initialRoute: '/',
    routes: {
      '/': (context) => const SimpleCalculatorPage(),
      '/scientific': (context) => const ScientificCalculatorPage(),
      '/currency': (context) => const CurrencyConverterPage(),
      '/unit': (context) => const UnitConverterPage(),
    },
  ));
}