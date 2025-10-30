import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_calculator/widgets/display.dart';

void main() {
  group('CalculatorDisplay Widget Tests', () {
    testWidgets('displays empty history, expression and result correctly', (WidgetTester tester) async {
      // Arrange
      const history = <String>[];
      const expression = '';
      const currentResult = '0';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('0'), findsOneWidget);
      expect(find.text('= 0'), findsOneWidget);
    });

    testWidgets('displays expression and result correctly', (WidgetTester tester) async {
      // Arrange
      const history = <String>[];
      const expression = '2+2';
      const currentResult = '4';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('2+2'), findsOneWidget);
      expect(find.text('= 4'), findsOneWidget);
    });

    testWidgets('displays history list correctly', (WidgetTester tester) async {
      // Arrange
      const history = <String>[
        '1+1=2',
        '3+5=8',
        '10-2=8',
      ];
      const expression = '5*3';
      const currentResult = '15';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 验证历史记录都显示了
      expect(find.text('1+1=2'), findsOneWidget);
      expect(find.text('3+5=8'), findsOneWidget);
      expect(find.text('10-2=8'), findsOneWidget);

      // Assert - 验证当前表达式和结果
      expect(find.text('5*3'), findsOneWidget);
      expect(find.text('= 15'), findsOneWidget);
    });

    testWidgets('displays multiple history items in ListView', (WidgetTester tester) async {
      // Arrange - 创建多个历史记录
      final history = List<String>.generate(10, (index) => '$index+$index=${index * 2}');
      const expression = '100+100';
      const currentResult = '200';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 验证 ListView 存在
      expect(find.byType(ListView), findsOneWidget);

      // Assert - 验证至少有一些历史记录显示
      expect(find.text('0+0=0'), findsOneWidget);
      expect(find.text('1+1=2'), findsOneWidget);
    });

    testWidgets('history ListView is scrollable', (WidgetTester tester) async {
      // Arrange - 创建足够多的历史记录以触发滚动
      final history = List<String>.generate(50, (index) => 'History item $index');
      const expression = 'test';
      const currentResult = '0';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 第一项应该可见
      expect(find.text('History item 0'), findsOneWidget);

      // Act - 滚动列表
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pump();

      // Assert - 滚动后，后面的项应该可见
      expect(find.text('History item 0'), findsNothing);
    });

    testWidgets('renders with correct text styles', (WidgetTester tester) async {
      // Arrange
      const history = <String>['1+1=2'];
      const expression = '5+5';
      const currentResult = '10';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 检查历史记录的文本样式
      final historyText = tester.widget<Text>(find.text('1+1=2'));
      expect(historyText.style?.fontSize, 14);
      expect(historyText.style?.color, Colors.white54);

      // Assert - 检查表达式的文本样式
      final expressionText = tester.widget<Text>(find.text('5+5'));
      expect(expressionText.style?.fontSize, 32);
      expect(expressionText.style?.color, Colors.white);

      // Assert - 检查结果的文本样式
      final resultText = tester.widget<Text>(find.text('= 10'));
      expect(resultText.style?.fontSize, 48);
      expect(resultText.style?.color, Colors.white);
      expect(resultText.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('container has correct styling', (WidgetTester tester) async {
      // Arrange
      const history = <String>[];
      const expression = '1+1';
      const currentResult = '2';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 检查 Container 的样式（找到第一个 Container）
      final containers = tester.widgetList<Container>(find.byType(Container));
      final displayContainer = containers.firstWhere(
        (container) => container.color == Colors.black,
      );
      expect(displayContainer.color, Colors.black);
    });

    testWidgets('handles long expression with overflow', (WidgetTester tester) async {
      // Arrange
      const history = <String>[];
      const expression = '1234567890+9876543210+1111111111+2222222222+3333333333';
      const currentResult = '17777777776';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 表达式文本应该存在（即使被截断）
      final expressionText = tester.widget<Text>(find.text(expression));
      expect(expressionText.overflow, TextOverflow.ellipsis);
      expect(expressionText.maxLines, 2);

      // Assert - 结果文本应该存在
      final resultText = tester.widget<Text>(find.text('= $currentResult'));
      expect(resultText.overflow, TextOverflow.ellipsis);
      expect(resultText.maxLines, 1);
    });

    testWidgets('renders Divider between history and current calculation', (WidgetTester tester) async {
      // Arrange
      const history = <String>['1+1=2'];
      const expression = '2+2';
      const currentResult = '4';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 验证 Divider 存在
      expect(find.byType(Divider), findsOneWidget);

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider.color, Colors.white30);
      expect(divider.height, 20);
    });

    testWidgets('all widgets are properly aligned', (WidgetTester tester) async {
      // Arrange
      const history = <String>[];
      const expression = '5+5';
      const currentResult = '10';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorDisplay(
              history: history,
              expression: expression,
              currentResult: currentResult,
            ),
          ),
        ),
      );

      // Assert - 检查 Column 的对齐方式
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.end);
    });
  });
}

