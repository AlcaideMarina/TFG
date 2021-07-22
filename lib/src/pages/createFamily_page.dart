//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';

class CreateFamilyPage extends StatefulWidget {
  CreateFamilyPage({Key key, @required this.id, @required this.user})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;

  @override
  _CreateFamilyPageState createState() => _CreateFamilyPageState(id: id, user: user);
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  _CreateFamilyPageState({this.id, this.user});
  final String id;
  final DocumentSnapshot user;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    String _nombre;
    String _apellidos;
    String _password;

    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            CustomBackgroundAll(),
            Container(
              padding:
                  EdgeInsets.only(top: _height * 0.05, left: _width * 0.55),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logoBlanco.png',
                    width: _width * 0.45,
                  ),
                  SizedBox(width: double.infinity)
                ],
              ),
            ),
            SingleChildScrollView(
                child: Column(children: [
              SafeArea(
                child: Container(
                  height: 120,
                ),
              ),
              Container(
                width: _width * 0.9,
                margin: EdgeInsets.symmetric(vertical: 30.0),
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26, //CustomColor.shadowColor,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 5.0)),
                  ],
                ),
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(children: [
                      Text('Crea una familia'),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                          'Rellena los campos para formar una familia.'),
                      SizedBox(height: 25.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Nombre de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _nombre = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Apellidos de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _apellidos = valor;
                                });
                              },
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Nombre de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _nombre = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(height: 40.0),
                            ElevatedButton(
                              onPressed: () async {
                                QuerySnapshot conf = await searchFamily(
                                    name: _nombre,
                                    surnames: _apellidos);
                                if (conf.docs.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                            title: new Text(
                                                'Revise el formulario'),
                                            content: new Text(
                                                'No existe ninguna familia que tenga esos datos. \nPor favor, revísa los campos, y asegúrate de que todo está correcto. Ten en cuenta todos los espacios, tildes, etc.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('De acuerdo.'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                }
                              },
                              child: Text('Únete a una familia'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColor.mainColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal[10]),
                                  //side: MaterialStateProperty.all<BorderSide>(),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                            ),
                            SizedBox(height: 10.0)
                          ],
                        ),
                      )
                    ])),
              ),
            ])),
            IconButton(
              padding: EdgeInsets.only(top: 100),
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
