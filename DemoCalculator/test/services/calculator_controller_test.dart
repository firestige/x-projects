import 'package:flutter_test/flutter_test.dart';
import 'package:demo_calculator/services/calculator_controller.dart';

void main() {
  group('CalculatorController', () {
    late CalculatorController controller;

    setUp(() {
      controller = CalculatorController();
    });

    group('Initial State', () {
      test('should have empty expression initially', () {
        expect(controller.expression, equals(''), reason: 'Expression should be empty, got: ${controller.expression}');
      });

      test('should have empty result initially', () {
        expect(controller.currentResult, equals(''), reason: 'Result should be empty, got: ${controller.currentResult}');
      });

      test('should have empty history initially', () {
        expect(controller.history, isEmpty, reason: 'History should be empty, got: ${controller.history}');
      });
    });

    group('Number Input', () {
      test('should handle single digit input', () {
        controller.handleInput('number', '5');
        expect(controller.expression, equals('5'), reason: 'Expression should be "5", got: ${controller.expression}');
      });

      test('should concatenate multiple digits into one number', () {
        controller.handleInput('number', '1');
        controller.handleInput('number', '2');
        controller.handleInput('number', '3');
        expect(controller.expression, equals('123'), reason: 'Expression should be "123", got: ${controller.expression}');
      });

      test('should auto-calculate result after number input', () {
        controller.handleInput('number', '5');
        expect(controller.currentResult, equals('5'), reason: 'Result should be "5", got: ${controller.currentResult}');
      });

      test('should handle decimal point input', () {
        controller.handleInput('number', '1');
        controller.handleInput('number', '.');
        controller.handleInput('number', '5');
        expect(controller.expression, equals('1.5'), reason: 'Expression should be "1.5", got: ${controller.expression}');
      });
    });

    group('Operator Input', () {
      test('should add operator after number', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        expect(controller.expression, equals('5+'), reason: 'Expression should be "5+", got: ${controller.expression}');
      });

      test('should replace last operators', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('operator', '-');
        expect(controller.expression, equals('5-'), reason: 'Expression should be "5-", got: ${controller.expression}');
      });

      test('should support addition operator', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('8'), reason: 'Result should be "8", got: ${controller.currentResult}');
      });

      test('should support subtraction operator', () {
        controller.handleInput('number', '10');
        controller.handleInput('operator', '-');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('7'), reason: 'Result should be "7", got: ${controller.currentResult}');
      });

      test('should support multiplication operator', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '*');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('15'), reason: 'Result should be "15", got: ${controller.currentResult}');
      });

      test('should support division operator', () {
        controller.handleInput('number', '15');
        controller.handleInput('operator', '/');
        controller.handleInput('number', '2');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('7.5'), reason: 'Result should be "7.5", got: ${controller.currentResult}');
      });

      test('should support modulo operator', () {
        controller.handleInput('number', '10');
        controller.handleInput('operator', '%');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('1'), reason: 'Result should be "1", got: ${controller.currentResult}');
      });
    });

    group('Clear Functions', () {
      test('clear command should clear expression and result', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('clear', null);
        expect(controller.expression, equals(''), reason: 'Expression should be empty, got: ${controller.expression}');
        expect(controller.currentResult, equals(''), reason: 'Result should be empty, got: ${controller.currentResult}');
      });

      test('clear command should not clear history', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        controller.handleInput('clear', null);
        expect(controller.history.length, equals(1), reason: 'History length should be 1, got: ${controller.history.length}');
      });

      test('clear_all command should clear everything including history', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        controller.handleInput('clear_all', null);
        expect(controller.expression, equals(''), reason: 'Expression should be empty, got: ${controller.expression}');
        expect(controller.currentResult, equals(''), reason: 'Result should be empty, got: ${controller.currentResult}');
        expect(controller.history, isEmpty, reason: 'History should be empty, got: ${controller.history}');
      });
    });

    group('Backspace Function', () {
      test('should delete last digit of number', () {
        controller.handleInput('number', '1');
        controller.handleInput('number', '2');
        controller.handleInput('number', '3');
        controller.handleInput('backspace', null);
        expect(controller.expression, equals('12'), reason: 'Expression should be "12", got: ${controller.expression}');
      });

      test('should delete single digit number', () {
        controller.handleInput('number', '5');
        controller.handleInput('backspace', null);
        expect(controller.expression, equals(''), reason: 'Expression should be empty, got: ${controller.expression}');
      });

      test('should delete operator', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('backspace', null);
        expect(controller.expression, equals('5'), reason: 'Expression should be "5", got: ${controller.expression}');
      });

      test('should handle backspace on empty expression', () {
        expect(() => controller.handleInput('backspace', null), returnsNormally);
        expect(controller.expression, equals(''), reason: 'Expression should be empty, got: ${controller.expression}');
      });

      test('should recalculate result after deleting digit', () {
        controller.handleInput('number', '5');
        controller.handleInput('number', '0');
        controller.handleInput('backspace', null);
        expect(controller.currentResult, equals('5'), reason: 'Result should be "5", got: ${controller.currentResult}');
      });
    });

    group('Equals Function', () {
      test('should calculate expression result', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('8'), reason: 'Result should be "8", got: ${controller.currentResult}');
      });

      test('should add history when starting new calculation', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        // History is only added when starting a new calculation
        expect(controller.history.length, equals(0), reason: 'History length should be 0, got: ${controller.history.length}');
        // After inputting new number, history should be added
        controller.handleInput('number', '7');
        expect(controller.history.length, equals(1), reason: 'History length should be 1, got: ${controller.history.length}');
        expect(controller.history[0], equals('5+3 = 8'), reason: 'History[0] should be "5+3 = 8", got: ${controller.history[0]}');
      });

      test('should start new calculation after equals', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);
        controller.handleInput('number', '7');
        expect(controller.expression, equals('7'), reason: 'Expression should be "7", got: ${controller.expression}');
        expect(controller.currentResult, equals('7'), reason: 'Result should be "7", got: ${controller.currentResult}');
      });

      test('should handle equals on empty expression', () {
        expect(() => controller.handleInput('equals', null), returnsNormally);
      });
    });

    group('Complex Expressions', () {
      test('should calculate expressions with multiple operators', () {
        controller.handleInput('number', '2');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('operator', '*');
        controller.handleInput('number', '4');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('14'), reason: 'Result should be "14", got: ${controller.currentResult}');
      });

      test('should handle decimal calculations', () {
        controller.handleInput('number', '2');
        controller.handleInput('number', '.');
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('number', '.');
        controller.handleInput('number', '5');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('6'), reason: 'Result should be "6", got: ${controller.currentResult}');
      });

      test('should handle operator precedence', () {
        controller.handleInput('number', '2');
        controller.handleInput('operator', '*');
        controller.handleInput('number', '3');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '4');
        controller.handleInput('equals', null);
        expect(controller.currentResult, equals('10'), reason: 'Result should be "10", got: ${controller.currentResult}');
      });
    });

    group('History Management', () {
      test('should record multiple calculation history', () {
        // First calculation
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);

        // Second calculation (triggers first calculation history)
        controller.handleInput('number', '10');
        expect(controller.history.length, equals(1), reason: 'History length should be 1, got: ${controller.history.length}');
        expect(controller.history[0], equals('5+3 = 8'), reason: 'History[0] should be "5+3 = 8", got: ${controller.history[0]}');

        controller.handleInput('operator', '-');
        controller.handleInput('number', '2');
        controller.handleInput('equals', null);

        // Third input triggers second calculation history
        controller.handleInput('number', '5');
        expect(controller.history.length, equals(2), reason: 'History length should be 2, got: ${controller.history.length}');
        expect(controller.history[0], equals('5+3 = 8'), reason: 'History[0] should be "5+3 = 8", got: ${controller.history[0]}');
        expect(controller.history[1], equals('10-2 = 8'), reason: 'History[1] should be "10-2 = 8", got: ${controller.history[1]}');
      });

      test('history should be unmodifiable', () {
        controller.handleInput('number', '5');
        controller.handleInput('operator', '+');
        controller.handleInput('number', '3');
        controller.handleInput('equals', null);

        var historySnapshot = controller.history;
        expect(() => historySnapshot.add('test'), throwsUnsupportedError);
      });
    });
  });

  group('StringExtensions', () {
    group('isNumeric Tests', () {
      test('should return true for integer string', () {
        expect('123'.isNumeric, isTrue, reason: '"123".isNumeric should be true');
      });

      test('should return true for decimal string', () {
        expect('123.456'.isNumeric, isTrue, reason: '"123.456".isNumeric should be true');
      });

      test('should return true for negative number string', () {
        expect('-123'.isNumeric, isTrue, reason: '"-123".isNumeric should be true');
      });

      test('should return false for non-numeric string', () {
        expect('abc'.isNumeric, isFalse, reason: '"abc".isNumeric should be false');
      });

      test('should return false for operator', () {
        expect('+'.isNumeric, isFalse, reason: '"+".isNumeric should be false');
      });

      test('should return false for empty string', () {
        expect(''.isNumeric, isFalse, reason: '"".isNumeric should be false');
      });
    });

    group('isOperator Tests', () {
      test('should return true for plus sign', () {
        expect('+'.isOperator, isTrue, reason: '"+".isOperator should be true');
      });

      test('should return true for minus sign', () {
        expect('-'.isOperator, isTrue, reason: '"-".isOperator should be true');
      });

      test('should return true for multiplication sign', () {
        expect('*'.isOperator, isTrue, reason: '"*".isOperator should be true');
      });

      test('should return true for division sign', () {
        expect('/'.isOperator, isTrue, reason: '"/".isOperator should be true');
      });

      test('should return true for modulo sign', () {
        expect('%'.isOperator, isTrue, reason: '"%".isOperator should be true');
      });

      test('should return false for number', () {
        expect('5'.isOperator, isFalse, reason: '"5".isOperator should be false');
      });

      test('should return false for letter', () {
        expect('a'.isOperator, isFalse, reason: '"a".isOperator should be false');
      });

      test('should return false for empty string', () {
        expect(''.isOperator, isFalse, reason: '"".isOperator should be false');
      });
    });
  });
}

