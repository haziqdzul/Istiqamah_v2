import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          width: width * .8,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: body),
    );
  }
}
