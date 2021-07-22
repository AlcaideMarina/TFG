import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class FamilyPieChart extends StatefulWidget {
  FamilyPieChart({Key key, @required this.mapMiembros, @required this.miembrosGrafico, @required this.suma});
  final Map<dynamic, dynamic> mapMiembros;
  final List<dynamic> miembrosGrafico;
  final dynamic suma;
  @override
  State<StatefulWidget> createState() => FamilyPieChartState(this.mapMiembros, this.miembrosGrafico, this.suma);
}

class FamilyPieChartState extends State {

  FamilyPieChartState(this.mapMiembros, this.miembrosGrafico, this.suma);
  final Map<dynamic, dynamic> mapMiembros;
  final List<dynamic> miembrosGrafico;
  final dynamic suma;

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                        pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch && pieTouchResponse.touchedSection != null) {
                      touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections()),
          ),
        ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(mapMiembros.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[0]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[0]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/M.png',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[1]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[1]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/J.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[2]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[2]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/L.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[3]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[3]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[4]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[4]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[5]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[5]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 6:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[6]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[6]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 7:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[7]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[7]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 8:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[8]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[8]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 9:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[9]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[9]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 10:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(double.parse((mapMiembros[miembrosGrafico[10]] / suma).toString()).toStringAsFixed(2)),
            title: double.parse(((mapMiembros[miembrosGrafico[10]] / suma) * 100).toString()).toStringAsFixed(2) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/random_user.png',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          return null;
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String image;
  final double size;
  final Color borderColor;

  const _Badge(
    this.image, {
    Key key,
    @required this.size,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        // child: SvgPicture.asset(
        //   svgAsset,
        //   fit: BoxFit.contain,
        // ),
        child: Image.asset(image, fit: BoxFit.contain)
      ),
    );
  }
}