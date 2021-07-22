import 'package:flutter/material.dart';

import '../customColor.dart';


class CustomBackgroundAll extends StatelessWidget {
  const CustomBackgroundAll({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        CustomColor.backgroundColor,
        CustomColor.darkerBackgroundColor
      ]
    )
  ),
);
  }
}