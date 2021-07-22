import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:homeconomy/custom/customColor.dart';

class GraphCard extends StatefulWidget {
  // final List<Color> availableColors = [
  //   Colors.purpleAccent,
  //   Colors.yellow,
  //   Colors.lightBlue,
  //   Colors.orange,
  //   Colors.pink,
  //   Colors.redAccent,
  // ];

  GraphCard({Key key, @required this.lista});
  List<dynamic> lista;

  @override
  State<StatefulWidget> createState() => _GraphCardState(this.lista);
}

class _GraphCardState extends State<GraphCard> {
  _GraphCardState(this.lista);
  List<dynamic> lista;

  final Color barBackgroundColor = CustomColor.almostWhiteColor;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    double yMaxValue = getMax(lista: lista);

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Gasto semanal',
                    style: TextStyle(
                        color: CustomColor.darkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // const SizedBox(
                  //   height: 38,
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.red,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    // yMaxValue = max(yMaxValue, y);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.redAccent] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: getMax(lista: lista) + 1,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  // List<BarChartGroupData> data() {

  // }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, lista[i].toDouble(),
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: CustomColor.darkColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Lunes';
                  break;
                case 1:
                  weekDay = 'Martes';
                  break;
                case 2:
                  weekDay = 'Miércoles';
                  break;
                case 3:
                  weekDay = 'Jueves';
                  break;
                case 4:
                  weekDay = 'Viernes';
                  break;
                case 5:
                  weekDay = 'Sábado';
                  break;
                case 6:
                  weekDay = 'Domingo';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: CustomColor.almostWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: CustomColor.mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'L';
              case 1:
                return 'M';
              case 2:
                return 'X';
              case 3:
                return 'J';
              case 4:
                return 'V';
              case 5:
                return 'S';
              case 6:
                return 'D';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 32,
          reservedSize: 14,
          getTitles: (value) {
            if (value == 0) {
              return '0';
            } else if (value == getMax(lista: lista) + 1) {
              try {
                return (getMax(lista: lista) + 1).toInt().toString();
              } catch (e) {
                return (getMax(lista: lista) + 1).toString();
              }
            } 
            // else if (value == 5) {
            //   return '5';
            // } else if (value == 10) {
            //   return '10';
            // } else if (value == 15) {
            //   return '15';
            // } else if (value == 20) {
            //   return '20';
            // } 
            else if (value == 25) {
              return '25';
            } else if (value == 50) {
              return '50';
            } else if (value == 75) {
              return '75';
            } else if (value == 100) {
              return '100';
            } else if (value == 125) {
              return '125';
            } else if (value == 150) {
              return '150';
            } else if (value == 200) {
              return '200';
            } else if (value == 500) {
              return '500';
            } else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        checkToShowHorizontalLine: (value) => value % 5 == 0,
      ),
    );
  }

  // BarChartData randomData() {
  //   return BarChartData(
  //     barTouchData: BarTouchData(
  //       enabled: false,
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: SideTitles(
  //         showTitles: true,
  //         getTextStyles: (value) => const TextStyle(
  //             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
  //         margin: 16,
  //         getTitles: (double value) {
  //           switch (value.toInt()) {
  //             case 0:
  //               return 'M';
  //             case 1:
  //               return 'T';
  //             case 2:
  //               return 'W';
  //             case 3:
  //               return 'T';
  //             case 4:
  //               return 'F';
  //             case 5:
  //               return 'S';
  //             case 6:
  //               return 'S';
  //             default:
  //               return '';
  //           }
  //         },
  //       ),
  //       leftTitles: SideTitles(
  //         showTitles: false,
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     barGroups: List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(0, 12,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 1:
  //           return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 2:
  //           return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 3:
  //           return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 4:
  //           return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 5:
  //           return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         case 6:
  //           return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
  //               barColor: widget.availableColors[
  //                   Random().nextInt(widget.availableColors.length)]);
  //         default:
  //           return null;
  //       }
  //     }),
  //   );
  // }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }

  double getMax({List<dynamic> lista}) {
    double max = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] > max) {
        max = lista[i];
      }
    }
    return max;
  }
}
