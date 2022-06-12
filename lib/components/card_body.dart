import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CardBody extends StatelessWidget {
  CardBody({required this.child, this.shape, this.radius, this.color,});

  final Widget child;

  BoxShape? shape;
  BorderRadius? radius;

  Color? color;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: color ?? kGreyColor,
      elevation: 5,
      shadowColor: Colors.black,
      shape: shape ?? BoxShape.rectangle,
      borderRadius: radius,
      child: child,
    );
  }
}
