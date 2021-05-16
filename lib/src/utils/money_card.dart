import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeconomy/src/get/getUserField.dart';

class CardMoney extends StatefulWidget {
  CardMoney({@required this.id});
  final String id;
  @override
  _CardMoneyState createState() => _CardMoneyState(id);
}

class _CardMoneyState extends State<CardMoney> {
  _CardMoneyState(this._id);
  final String _id;
  final GlobalKey _menuKey = new GlobalKey();

  GetUserField _account;
  GetUserField _money;

  @override
  Widget build(BuildContext context) {
    
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    _account = GetUserField(id: _id,  field: 'bankAccount');
    _money = GetUserField(id: _id, field: 'Money');


    //_account = GetUserField(_id, 'bankAccount');
    //_money = GetUserField(_id, 'Money');



    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment(-0.9, 1.0),
            child: Container(
              child: Text(
                'Libreta de ahorro:',
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Align(
            alignment: Alignment(-0.70, 1.0),
            child: Container(
              child: _account
            ),
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment(0.9, 1.0),
            child: Container(
              child: _money
              /* Text(
                'Dinero',
                style: TextStyle(fontSize: 40),*/
              ),
            ),
          //),
          SizedBox(height: 7.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: _width - 390),
                width: _width / 100,
                child: Icon(Icons.credit_card), 
              ),
              Container(
                //padding: EdgeInsets.symmetric(horizontal: _width - 400),
      
                child: Text('Tarjeta'), 
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _width - 380),
                child: Text('Bloquear tarjeta'), 
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: _width - 380),
              //   child: Switch(value: false, onChanged: (() {
              //     return true;
              //   })), 
              // ),
            ],
          ),
          SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
