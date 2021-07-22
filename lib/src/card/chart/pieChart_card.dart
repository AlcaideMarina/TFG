import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:homeconomy/custom/customColor.dart';
//import 'indicator.dart';

class PieChartCard extends StatefulWidget {
  PieChartCard({Key key, @required this.listaCategorias, @required this.cantidadTransacciones});

  final Map<dynamic, dynamic> listaCategorias;
  final int cantidadTransacciones; 

  @override
  State<StatefulWidget> createState() => PieChartCardState(this.listaCategorias, this.cantidadTransacciones);
   
}

class PieChartCardState extends State<PieChartCard> {

  PieChartCardState(this.listaCategorias, this.cantidadTransacciones);

  Map<dynamic, dynamic> listaCategorias;
  int cantidadTransacciones;

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //SizedBox(height: .0),
              Text(
                'Gasto por categorías',
                style: TextStyle(
                    color: CustomColor.darkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                setState(() {
                                  final desiredTouch = pieTouchResponse
                                          .touchInput is! PointerExitEvent &&
                                      pieTouchResponse.touchInput
                                          is! PointerUpEvent;
                                  if (desiredTouch &&
                                      pieTouchResponse.touchedSection != null) {
                                    touchedIndex = pieTouchResponse
                                        .touchedSection.touchedSectionIndex;
                                  } else {
                                    touchedIndex = -1;
                                  }
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: _width * 0.1,
                              sections: showingSections()),
                        ),
                      ),
                    ),
                  ),
                  // Column(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: const <Widget>[
                  //     Indicator(
                  //       color: Color(0xff0293ee),
                  //       text: 'First',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: Color(0xfff8b250),
                  //       text: 'Second',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: Color(0xff845bef),
                  //       text: 'Third',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: Color(0xff13d38e),
                  //       text: 'Fourth',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 18,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  List<PieChartSectionData> showingSections() {
    if(listaCategorias != null){
listaCategorias.forEach((k, v) {
      listaCategorias[k] = v / cantidadTransacciones;
    });
    return List.generate(cantidadTransacciones, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey, //const Color(0xff0293ee),
            value: listaCategorias[0],
            title: listaCategorias[0].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(4294950233),
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 21,
            title: '21%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 9,
            title: '9%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 7:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 8:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 9:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 10:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 11:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 12:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 13:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 14:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 15:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 16:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 17:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 18:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 19:
          return PieChartSectionData(
            color: CustomColor.darkerBackgroundColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
    }
    
  }
}
