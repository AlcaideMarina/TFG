import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//import 'package:fl_chart/fl_chart.dart';
/* 
Do this in your terminal
flutter channel dev
flutter upgrade
*/

class GraphCard extends StatefulWidget {
  @override
  _GraphCardState createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final List<BarChartModel> data = [
  BarChartModel(
    year: "2014",
    financial: 250,
    color: charts.ColorUtil.fromDartColor
    (Color(0xFF47505F)),
  ),
  BarChartModel(
    year: "2015",
    financial: 300,
    color: charts.ColorUtil.fromDartColor
    (Colors.red),
  ),
  BarChartModel(
    year: "2016",
    financial: 100,
    color: charts.ColorUtil.fromDartColor
    (Colors.green),
  ),
  BarChartModel(
    year: "2017",
    financial: 450,
    color: charts.ColorUtil.fromDartColor
    (Colors.yellow),
  ),
  BarChartModel(
    year: "2018",
    financial: 630,
    color: charts.ColorUtil.fromDartColor
    (Colors.lightBlueAccent),
  ),
  BarChartModel(
    year: "2019",
    financial: 1000,
    color: charts.ColorUtil.fromDartColor
    (Colors.pink),
  ),
  BarChartModel(
    year: "2020",
    financial: 400,
    color: charts.ColorUtil.fromDartColor
    (Colors.purple),
  ),
];
/*
List<charts.Series<BarChartModel, String>> series = [
    charts.Series(
        id: "Financial",
        data: widget.data,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color),
  ];
  */

    return Card(
      elevation: 10.0,
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 15.0),
          Text('BarChart'),
          SizedBox(height: 300.0)

        ],
      ),
    );
  }
}
class BarChartModel {
  String month;
  String year;
  int financial;
  final charts.Color color;

  BarChartModel({this.month, 
  this.year, this.financial, 
  this.color,}
);
}