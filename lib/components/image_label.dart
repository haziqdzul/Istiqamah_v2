import 'package:flutter/material.dart';
import 'package:istiqamah_app/constants/constant.dart';

import 'card_body.dart';

class DefaultImageLabel extends StatelessWidget {
  DefaultImageLabel(
      {required this.label, required this.imageUrl, this.onPress});
  final String label;
  final String imageUrl;
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardBody(
            radius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 150,
                height: 120,
              ),
            ),
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
