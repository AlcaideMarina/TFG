import 'package:flutter/material.dart';
import 'package:homeconomy/src/utils/card1.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //este primer return creo que lo voy a quitar porque realmente no lo necesito así al menos al ppio
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          elevation: 10.0,
          toolbarHeight: 90.0,
          bottom: TabBar(
            indicatorColor: Colors.green[100],
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Creates border
                color: Colors.teal[100]),
            isScrollable: true,
            indicatorWeight: 5.0,
            tabs: [
              Text('Home'),
              Text('hola1'),
              Text('hola2'),
              Text('hola3'),
              Text('hola4'),
              Text('hola5'),
              Text('hola6'),
              Text('hola7'),
              Text('hola8'),
              Text('hola9'),
              Text('hola0'),
              Text('hola1'),
              //Tab(icon: Icon(Icons.flight)),
              //Tab(icon: Icon(Icons.directions_transit)),
              //Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          
        ),
        body: TabBarView(
          children: [
            Text('Home'),
            Text('hola1'),
            Text('hola2'),
            Text('hola3'),
            Text('hola4'),
            Text('hola5'),
            Text('hola6'),
            Text('hola7'),
            Text('hola8'),
            Text('hola9'),
            Text('hola0'),
            Text('hola1'),
            //Icon(Icons.flight, size: 350),
            //Icon(Icons.directions_transit, size: 350),
            //Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          
        ]),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          CardDineroTotal(),
        ],
      ),
    );
  }
}
