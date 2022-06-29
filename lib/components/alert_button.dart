import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    required this.label,
    required this.textStyle,
    this.decoration,
    this.onPress,
    this.value,
  });

  BoxDecoration? decoration;
  final String label;
  final TextStyle? textStyle;
  VoidCallback? onPress;
  String? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: decoration,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
