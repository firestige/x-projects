import 'package:flutter/widgets.dart';

class ScientificCalculatorPage extends StatefulWidget {
  const ScientificCalculatorPage({super.key});

  @override
  State<ScientificCalculatorPage> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Scientific Calculator Page'),
    );
  }
}