import 'package:flutter/material.dart';

import '../constants/constant.dart';
import 'card_body.dart';

class DefaultCircleCard extends StatelessWidget {
  DefaultCircleCard({required this.label, required this.icon, this.onPress});

  final String label;
  final Widget icon;
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // margin: EdgeInsets.all(10),
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardBody(
            shape: BoxShape.circle,
            child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: icon),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 100,
              child: Text(label,
                  textAlign: TextAlign.center, style: textStyleNormal)),
        ],
      ),
    );
  }
}
