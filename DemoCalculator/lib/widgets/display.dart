import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final List<String> history;
  final String expression;
  final String currentResult;

  const CalculatorDisplay({super.key, required this.history, required this.expression, required this.currentResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerRight,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    history[index],
                    style: const TextStyle(
                      fontSize:14,
                      color: Colors.white54,
                    ),
                    textAlign: TextAlign.left,
                  )
                );
              }
            )
          ),
          const Divider(color: Colors.white30, height: 20),
          Text(
            expression.isEmpty ? '0' : expression,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          Text(
            '= $currentResult',
            style: const TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}