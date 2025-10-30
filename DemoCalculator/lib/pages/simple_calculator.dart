import 'package:demo_calculator/services/calculator_controller.dart';
import 'package:demo_calculator/widgets/simple_calculator_button_grid.dart';
import 'package:flutter/material.dart';

import '../widgets/display.dart';

class SimpleCalculatorPage extends StatefulWidget {
  const SimpleCalculatorPage({super.key});

  @override
  State<SimpleCalculatorPage> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculatorPage> {

  final _controller = CalculatorController();

  void _handleButtonPress(String cmd, String?value) {
    setState(() {
      _controller.handleInput(cmd, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator'),),
      body: Column(
        children: [
          Expanded(
              child: CalculatorDisplay(
                expression: _controller.expression,
                currentResult: _controller.currentResult,
                history: _controller.history,
              ),
          ),
          const SizedBox(height: 20,),
          SimpleCalculatorButtonGrid(
            onPressed: _handleButtonPress,
          ),
        ],
      ),
    );
  }
}
