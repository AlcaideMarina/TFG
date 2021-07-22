import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';


class CustomBackgroundTop extends StatelessWidget {
  const CustomBackgroundTop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    
    return Container(
        height: _height * 0.6,
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          CustomColor.mainColor,
          CustomColor.gradientColor
        ])));
  }
}