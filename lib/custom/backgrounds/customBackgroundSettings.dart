import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'dart:math';


class CustomBackgroundSettings extends StatelessWidget {
  //const CustomBackgroundSettings({Key key}) : super(key: key);

  final boxDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 0.8],
        colors: [CustomColor.backgroundColor, CustomColor.mainColor]),
  );

  final box1 = Transform.rotate(
    angle: -pi / 4, 
    child: Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        gradient: LinearGradient(
          colors: [
            CustomColor.contrasteColor,
            CustomColor.darkConstanteColor,
          ]
        ),
      )
    )
  );
  final box2 = Transform.rotate(
    angle: -pi / 6.5, 
    child: Container(
      width: 230,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        gradient: LinearGradient(
          colors: [
            CustomColor.softContrasteColor,
            CustomColor.contrasteColor,
          ]
        ),
      )
    )
  );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Container(decoration: boxDecoration,),
        Positioned(child: box1, top: -100, right: -80),
        Positioned(child: box2, top: 250, left: -80)]);
  }
}


