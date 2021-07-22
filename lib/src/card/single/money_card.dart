import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/get/getUserField.dart';

class MoneyCard extends StatelessWidget {
  MoneyCard({Key key, @required this.id, @required this.idCuentaBancaria, @required this.user})
  : super(key: key);

  final String id;
  final String idCuentaBancaria;
  final DocumentSnapshot user;
  //final String _accountId;this._accountId
  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    String _accountNumber;
    String _currentMoney;

    // dynamic _accountArray = GetUserField(id: id, field: 'bankAccount');
    // dynamic _money = GetUserField(id: id, field: 'Money');

    //getUserFieldWithId(id: _id, field: 'bankAccount').then((value) => _baId = value);

    //_account = GetUserField(_id, 'bankAccount');
    //_money = GetUserField(_id, 'Money');

    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('bankAccounts')
            .doc(idCuentaBancaria)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final allFields = snapshot.data;
          if (snapshot.hasData) {
            dynamic nombre = allFields['Name'] == null ? 'Cuenta' : allFields['Name'];
            dynamic dinero = allFields['Money'];
            dynamic cuenta = allFields['AccountNumber'];
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                    child: Text(nombre + ':', style: TextStyle(fontSize: 18.0))
                  ),
                  //SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                    child: Stack(children: [
                      Text(cuenta, style: TextStyle(fontSize: 16.0),)
                    ],)
                    
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 25.0),
                    child: Text(dinero.toString() + " €", style: TextStyle(fontSize: 30.0),),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
