import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';

class LineChartCard extends StatefulWidget {
  LineChartCard({Key key, @required this.lista});
  final List<dynamic> lista;
  @override
  State<StatefulWidget> createState() => _LineChartCardState(lista: this.lista);
}

class _LineChartCardState extends State<LineChartCard> {
  _LineChartCardState({this.lista});
  List<dynamic> lista;
  

  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Container(
          margin: EdgeInsets.fromLTRB(15.0, 15.0, 20.0, 5.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Text('Tus próximos gastos e ingresos', style: TextStyle(
                        color: CustomColor.darkColor, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 5.0),
                      child: LineChart(
                        isShowingMainData ? sampleData1() : sampleData1(),
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: CustomColor.softColor.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          margin: 10,
          getTitles: (value) {
            DateTime now = new DateTime.now();
            // DateTime date = new DateTime(now.month, now.day + 3);
            // print(date.toString().substring(5, 10));

            switch (value.toInt()) {
              case 0:
                return 'HOY';
              case 2:
                return now.add(Duration(days: 2)).toString().substring(8, 10) + '/' +  now.add(Duration(days: 2)).toString().substring(5, 7);
              case 5:
                return now.add(Duration(days: 5)).toString().substring(8, 10) + '/' +  now.add(Duration(days: 5)).toString().substring(5, 7);
              case 8:
                return now.add(Duration(days: 8)).toString().substring(8, 10) + '/' +  now.add(Duration(days: 8)).toString().substring(5, 7);
              case 11:
                return now.add(Duration(days: 11)).toString().substring(8, 10) + '/' +  now.add(Duration(days: 11)).toString().substring(5, 7);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          // getTitles: (value) {
          //   print('hola');
          //   switch (value.toInt()) {
          //     case -500:
          //       return '1m';
          //     case 0:
          //       return '2m';
          //     case 200:
          //       return '3m';
          //     case 300:
          //       return '5m';
          //   }
          //   return '';
          // },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: lista.length.toDouble() - 1,
      maxY: getMaxY(lista: lista) + 50,
      minY: getMinY(lista: lista) - 50,
      lineBarsData: linesBarData1(),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(y: 0)
      ])
    );
  }

  List<LineChartBarData> linesBarData1() {
    List<FlSpot> spots = [];
    lista.asMap().forEach((index, value) {
      spots.add(FlSpot(index.toDouble(), value));  
    });

    final lineChartBarData1 = LineChartBarData(
      spots: 
        spots
        // FlSpot(0, lista[0]),
        // FlSpot(1, lista[1]),
        // FlSpot(2, lista[2]),
        // FlSpot(3, lista[3]),
        // FlSpot(4, lista[4]),
        // FlSpot(5, lista[5]),
        // FlSpot(6, lista[6]),
        // FlSpot(7, lista[7]),
        // FlSpot(8, lista[8]),
        // FlSpot(9, lista[9]),
        // FlSpot(10, lista[10]),
        // FlSpot(11, lista[11]),
        // FlSpot(13, 1.8),
      ,
      isCurved: true,
      colors: [
        //const Color(0xff4af699),
        CustomColor.mainColor
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    //HorizontalLine(y: 0);

    return [lineChartBarData1];
  }

  

/*
  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: getMaxY(lista: lista),
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
*/
  double getMaxY({List<dynamic> lista}) {
    double max = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] > max) {
        max = lista[i];
      }
    }
    return max;
  }

  double getMinY({List<dynamic> lista}) {
    double min = double.infinity;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] < min) {
        min = lista[i];
      }
    }
    return min;
  }
}
