import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'abstract_button_grid.dart';

class SimpleCalculatorButtonGrid extends AbstractButtonGrid {
  const SimpleCalculatorButtonGrid({super.key, required super.onPressed});

  @override
  List<Widget> buildButtons(BuildContext context) {
    return [
      // first line
      createButton(label: 'C', cmd: 'clear'),
      createButton(label: 'del', cmd: 'backspace', icon: MaterialSymbols.backspace),
      createOperatorButton('%'),
      createOperatorButton('/'),


      // second line
      createNumberButton(7),
      createNumberButton(8),
      createNumberButton(9),
      createOperatorButton('*'),

      // third line
      createNumberButton(4),
      createNumberButton(5),
      createNumberButton(5),
      createOperatorButton('-'),

      // fourth line
      createNumberButton(1),
      createNumberButton(2),
      createNumberButton(3),
      createOperatorButton('+'),

      // fifth line
      createButton(label: 'change', cmd: 'next', icon: MaterialSymbols.cached),
      createNumberButton(0),
      createNumberButton('.'),
      createButton(label: '=', cmd: 'equals', color: Colors.orange),
    ];
  }
}