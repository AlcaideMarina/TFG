import 'package:flutter/material.dart';

class CardDineroTotal extends StatefulWidget {
  @override
  _CardDineroTotalState createState() => _CardDineroTotalState();
}

class _CardDineroTotalState extends State<CardDineroTotal> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Dinero disponible en la cuenta:'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              
            ],
          ),
        ],
      ),
    );
  }
}
