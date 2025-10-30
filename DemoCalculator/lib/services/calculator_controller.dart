import 'expression_evaluator.dart';

class CalculatorController {
  final List<String> _expression = [];
  String _currentResult = '';
  final List<String> _history = [];
  bool _isCalculating = true;

  handleInput(String cmd, String?value) {
    if (!_isCalculating) {
      _history.add('$expression = $_currentResult');
      _currentResult = '';
      _expression.clear();
      _isCalculating = true;
    }
    switch(cmd) {
      case 'number':
        String last = _expression.isNotEmpty ? _expression.last : '';
        if (last.isNumeric) {
          _expression.removeLast();
          _expression.add(last + (value ?? ''));
        } else {
          _expression.add(value ?? '');
        }
        calculate();
        break;
      case 'operator':
        String last = _expression.isNotEmpty ? _expression.last : '';
        if (last.isOperator) {
          _expression.removeLast();
          _expression.add(last + (value ?? ''));
        } else {
          _expression.add(value ?? '');
        }
        break;
      case 'clear':
        _expression.clear();
        _currentResult = '';
        break;
      case 'clear_all':
        _expression.clear();
        _currentResult = '';
        _history.clear();
        break;
      case 'backspace':
        if (expression.isNotEmpty) {
          String last = _expression.isNotEmpty ? _expression.last : '';
          if (last.isOperator) {
            _expression.removeLast();
          } else if (last.isNumeric) {
            if (last.length > 1) {
              _expression.removeLast();
              _expression.add(last.substring(0, last.length - 1));
            } else {
              _expression.removeLast();
            }
          }
          calculate();
        }
        break;
      case 'equals':
        if (expression.isNotEmpty) {
          calculate();
        }
        _isCalculating = false;
        break;
    }
  }

  void calculate() {
    _currentResult = evaluateExpression(expression);
  }

  String get expression => _expression.join('');
  String get currentResult => _currentResult;
  List<String> get history => List.unmodifiable(_history);


}

extension StringExtensions on String {
  bool get isNumeric => double.tryParse(this) != null;
  bool get isOperator => ['+', '-', '*', '/', '%'].contains(this);
}
