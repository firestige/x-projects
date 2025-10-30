import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

abstract class AbstractButtonGrid extends StatelessWidget {
  final void Function(String cmd, String?value) onPressed;

  const AbstractButtonGrid({
    super.key,
    required this.onPressed,
  });

  List<Widget> buildButtons(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 1.0,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: buildButtons(context),
    );
  }

  Widget createNumberButton(dynamic number) {
    return createButton(
      label: number.toString(),
      cmd: 'number',
      value: number.toString(),
    );
  }

  Widget createOperatorButton(String operator) {
    return createButton(
      label: operator,
      cmd: 'operator',
      value: operator,
      color: Colors.orange,
    );
  }

  Widget createButton({
    required String label,
    String? cmd,
    String? value,
    Color? color,
    Color? textColor,
    String? icon,
    double size = 24.0,
  }) {
    return ElevatedButton(
      onPressed: () => onPressed(cmd ?? label, value),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey[800],
        foregroundColor: textColor ?? Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20.0),
      ),
      child: _buildIconButtonContent(
        label: label,
        icon: icon,
        textColor: textColor,
        size: size,
      )
    );
  }

  Widget _buildIconButtonContent({
    required String label,
    String? icon,
    Color? textColor,
    double size = 24.0,
  }) {
    if (icon != null) {
      return Iconify(
        icon,
        color: textColor ?? Colors.white,
        size: size,
      );
    } else {
      return Text(
        label,
        style: TextStyle(
          fontSize: size,
          color: textColor ?? Colors.white,
        ),
      );
    }
  }
}