import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundSettings.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class MyBankAccountsSettingsPage extends StatefulWidget {
  MyBankAccountsSettingsPage(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _MyBankAccountsSettingsPageState createState() =>
      _MyBankAccountsSettingsPageState(this.id, this.user, this.familyId);
}

class _MyBankAccountsSettingsPageState
    extends State<MyBankAccountsSettingsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  _MyBankAccountsSettingsPageState(this.id, this.user, this.familyId);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(
        id: id,
        user: user,
        currentPage: 'SettingsPage',
      ),
      body: Stack(
        children: [
          CustomBackgroundSettings(),
          // SafeArea(
          //     bottom: false,
          //     child: Container(
          //       height: _height * 0.8,
          //     )),
          SingleChildScrollView(
            child: Container(
                //width: _width * 0.9,
                child: Column(children: [
              SafeArea(
                  //bottom: false,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      height: _height * 0.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.0),
                          Text(
                            'Mis cuentas',
                            style: TextStyle(
                                fontSize: 23.0,
                                color: CustomColor.almostBlackColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ))),
              SizedBox(height: 7.0),
              Align(
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(id)
                            .collection('bankAccounts')
                            .snapshots(),
                        builder: (context, snapshot) {
                          final allBankAccounts = snapshot.data;
                          if (snapshot.hasData) {
                            return Container(
                              width: _width * 0.9,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: allBankAccounts.docs.length,
                                  itemBuilder: (context, index) {
                                    dynamic baActual = allBankAccounts.docs[index].id;
                                    return SafeArea(
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(id)
                                              .collection('bankAccounts')
                                              .doc(baActual)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            final allFields = snapshot.data;
                                            if (snapshot.hasData &&
                                                !snapshot.hasError) {
                                              String numCuenta =
                                                  allFields['AccountNumber'];
                                              String nombreCuenta =
                                                  allFields['Name'];
                                              //String nombreUsuario = user['Nombre'];
                                              if (nombreCuenta != null) {
                                                return Container(
                                                    width: _width * 0.8,
                                                    child: GestureDetector(
                                                        child: Card(
                                                            elevation: 10.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Número de cuenta:'),
                                                                    SizedBox(
                                                                        height:
                                                                            5.0),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        numCuenta,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.0),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15.0),
                                                                    Text(
                                                                        'Nombre de la cuenta:'),
                                                                    SizedBox(
                                                                        height:
                                                                            5.0),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        nombreCuenta,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17.0),
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //     height:
                                                                    //         15.0),
                                                                    // Row(
                                                                    //   mainAxisAlignment:
                                                                    //       MainAxisAlignment
                                                                    //           .spaceAround,
                                                                    //   children: [
                                                                    //     IconButton(
                                                                    //         onPressed:
                                                                    //             () {},
                                                                    //         tooltip:
                                                                    //             'Eliminar',
                                                                    //         icon:
                                                                    //             Icon(Icons.delete_outline_rounded)),
                                                                    //     IconButton(
                                                                    //         onPressed:
                                                                    //             () {},
                                                                    //         tooltip:
                                                                    //             'Modificar',
                                                                    //         icon:
                                                                    //             Icon(Icons.edit_rounded)),
                                                                    //   ],
                                                                    // )
                                                                  ],
                                                                )))));
                                              } else {
                                                return Container(
                                                    width: _width * 0.9,
                                                    child: GestureDetector(
                                                        child: Card(
                                                            elevation: 10.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Número de cuenta:'),
                                                                    SizedBox(
                                                                        height:
                                                                            5.0),
                                                                    Text(
                                                                      '\t\t\t' +
                                                                          numCuenta,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                    // SizedBox(
                                                                    //     height:
                                                                    //         15.0),
                                                                    // Row(
                                                                    //   mainAxisAlignment:
                                                                    //       MainAxisAlignment
                                                                    //           .spaceAround,
                                                                    //   children: [
                                                                    //     IconButton(
                                                                    //         onPressed:
                                                                    //             () {},
                                                                    //         tooltip:
                                                                    //             'Eliminar',
                                                                    //         icon:
                                                                    //             Icon(Icons.delete_outline_rounded)),
                                                                    //     IconButton(
                                                                    //         onPressed:
                                                                    //             () {},
                                                                    //         tooltip:
                                                                    //             'Modificar',
                                                                    //         icon:
                                                                    //             Icon(Icons.edit_rounded)),
                                                                    //   ],
                                                                    // )
                                                                  ],
                                                                )))));
                                              }
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          }),
                                    );
                                  }),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ))
            ])),
          ),
          IconButton(
            padding: EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: CustomColor.mainColor,
        backgroundColor: CustomColor.darkColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddBankAccountPage(id: id, user: user, familyId: familyId)),
          );
        },
        tooltip: 'Añadir nueva cuenta',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddBankAccountPage extends StatefulWidget {
  AddBankAccountPage(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _AddBankAccountPageState createState() =>
      _AddBankAccountPageState(this.id, this.user, this.familyId);
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  _AddBankAccountPageState(this.id, this.user, this.familyId);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nombre;
  String numeroCuenta;
  String numeroCuenta2;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuProvider(
          id: id,
          user: user,
          currentPage: 'SettingsPage',
        ),
        body: Stack(children: [
          CustomBackgroundSettings(),
          SingleChildScrollView(
              child: Column(children: [
            SafeArea(
                //bottom: false,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: _height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.0),
                        Text(
                          'Añadir cuenta',
                          style: TextStyle(
                              fontSize: 23.0,
                              color: CustomColor.almostBlackColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ))),
            Column(children: [
              SizedBox(height: 10.0),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                      color: CustomColor.almostWhiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 5.0))
                      ]),
                  key: _formKey,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(children: [
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            cursorColor: CustomColor.mainColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              labelText: 'Nombre',
                            ),
                            // initialValue: nombre,
                            onChanged: (valor) {
                              setState(() {
                                nombre = valor;
                              });
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: CustomColor.mainColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              labelText: 'Número de cuenta',
                            ),
                            //initialValue: precio.toString(),
                            onChanged: (valor) {
                              setState(() {
                                numeroCuenta = valor;
                              });
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: CustomColor.mainColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              labelText:
                                  'Vuelva a introducir el número de cuenta',
                            ),
                            //initialValue: precio.toString(),
                            onChanged: (valor) {
                              setState(() {
                                numeroCuenta2 = valor;
                              });
                            }),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            if (numeroCuenta == null ||
                                numeroCuenta == '' ||
                                numeroCuenta2 == null ||
                                numeroCuenta2 == '') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Campos vacíos'),
                                  content: Text(
                                      'No ha introducido todos los datos. Por favor, revise el formulario.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Aceptar')),
                                  ],
                                ),
                              );
                            } else if (numeroCuenta2 != numeroCuenta) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Revise los números de cuenta'),
                                  content: Text(
                                      'Los números de cuenta introducidos no coinciden. Por favor, revíselos, es una manera de prevenir error.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Aceptar')),
                                  ],
                                ),
                              );
                            } else if (nombre == null || nombre == '') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Atención'),
                                  content: Text(
                                      'No ha introducido un nombre de cuenta. Le recordamos que este nombre no tiene que coincidir con el del banco ni es nada oficial. Es simplemente una forma de que le sea más fácil identificar sus cuentas. ¿Está seguro de que desea continuar?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          saveButton(
                                              nombreSave: nombre,
                                              numeroCuentaSave: numeroCuenta);
                                        },
                                        child: Text('Seguir así')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Añadir un nombre')),
                                  ],
                                ),
                              );
                            } else {
                              saveButton(
                                  nombreSave: nombre,
                                  numeroCuentaSave: numeroCuenta);
                            }
                          },
                          child: Text('Añadir'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColor.mainColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  CustomColor.softColor),
                              //side: MaterialStateProperty.all<BorderSide>(),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                        ),
                        SizedBox(height: 10.0)
                      ]))),
              SizedBox(height: 30.0)
            ]),
          ])),
          IconButton(
            padding: EdgeInsets.only(top: 60),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                          id: id, user: user, familyId: familyId)),
                ),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ]));
  }

  saveButton({String nombreSave, String numeroCuentaSave}) async {
    Random rnd = new Random(DateTime.now().millisecondsSinceEpoch);
    num start = 748.23;
    num end = 3876.23;
    double dinero = double.parse(
        (rnd.nextDouble() * (end - start) + start).toStringAsFixed(2));

    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('bankAccounts');

    DocumentReference doc = await db.add({
      'Name': nombreSave,
      'AccountNumber': numeroCuentaSave,
      'userId': id,
      'Money': dinero
    });

    String conf = 'false';

    conf = await getBankAccount(baId: doc.id, id: id);

    String titulo = '';
    String contenido = '';
    if (conf == 'true') {
      titulo = 'Se ha guardado la cuenta';
      contenido = 'El registro de la cuenta se ha guardado correctamente.';
    } else {
      titulo = 'Ha ocurrido un error';
      contenido =
          'Se ha producido un error al guardar los datos.\nMensaje de error: ' +
              conf;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBankAccountsSettingsPage(
                          id: id, user: user, familyId: familyId)),
                );
              },
              child: Text('Aceptar')),
        ],
      ),
    );
  }
}
