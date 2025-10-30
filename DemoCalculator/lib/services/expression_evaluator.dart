import 'package:math_expressions/math_expressions.dart';

String evaluateExpression(String expression) {
  if (expression.trim().isEmpty) return "0";
  try {
    if (expression.trim().isEmpty) return "0";
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    final eval = RealEvaluator(cm);
    num evalResult = eval.evaluate(exp);
    String resultStr = evalResult.toStringAsFixed(8);
    resultStr = resultStr.replaceAll(RegExp(r'\.?0+$'), '');
    if (resultStr.endsWith('.')) {
      resultStr = resultStr.substring(0, resultStr.length - 1);
    }
    return resultStr;
  } catch (e) {
    return "Error";
  }
}