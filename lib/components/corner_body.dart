import 'package:flutter/material.dart';

import 'default_scaffold.dart';

class CornerBody extends StatelessWidget {
  CornerBody({required this.body, this.bodyHeight});

  final Widget body;

  double? bodyHeight;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultBody(
        body: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 30),
          height: bodyHeight,
          width: width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(75),
            ),
          ),
          child: body,
    ));
  }
}
