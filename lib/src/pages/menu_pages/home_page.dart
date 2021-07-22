import 'dart:async';

import 'package:auth/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customUserBottomNav.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/card/chart/graph_card%20copy.dart';
import 'package:homeconomy/src/card/chart/lineChart_card.dart';
import 'package:homeconomy/src/card/chart/pieChart_card%20copy.dart';
import 'package:homeconomy/src/card/chart/pieChart_card.dart';
import 'package:homeconomy/src/card/single/user_card.dart';
import 'package:homeconomy/src/get/getUser.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';
import 'package:homeconomy/src/card/chart/graph_card.dart';
import 'package:homeconomy/src/card/single/money_card.dart';
import 'package:homeconomy/custom/customColor.dart';

import 'package:homeconomy/src/pages/login_page.dart';

//import 'dart:async'; // ya está importado arriba
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({@required this.id, @required this.user});
  final String id;
  final DocumentSnapshot user;

  @override
  _HomePageState createState() => _HomePageState(id, user);
}

class _HomePageState extends State<HomePage> {
  // String _name = 'loading...';
  // String _surname = 'loading...';
  // String _imageUrl = 'assets/random_user.png';
  // Image _image;

  DocumentSnapshot getUser;

  Future<Prediction> pred;

  @override
  void initState() {
    super.initState();
    pred = fetchPrediction();
  }

  // getValues() async {
  //   _name = await getUserFieldWithId(id: _id, field: 'Nombre');
  //   _surname = await getUserFieldWithId(id: _id, field: 'Apellido');
  //   _imageUrl = await getUserFieldWithId(id: _id, field: 'Image');
  //   setState((){});
  // }

  _HomePageState(this._id, this.user);
  final String _id;
  final DocumentSnapshot user;
  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    //_name = _user.get('Nombre');
    //Future<dynamic> user = getUser(widget.id);

    // Firebase.initializeApp();
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    //_user.get('Nombre');
    //getUserFieldWithId(id: _id, field: 'Nombre').then((value) => _name = value);
    // getUserFieldWithId(id: _id, field: 'Apellidos')
    //     .then((value) => _surname = value);
    // getUserFieldWithId(id: _id, field: 'Imagen')
    //     .then((value) => _imageUrl = value);
    //getBATotalNumber(id: _id).then((value) => null);
    //if (_imageUrl == '') {
    // if (_imageUrl == 'assets/random_user.png') {
    //   _image = Image.asset(_imageUrl);
    // } else {
    //   _image = Image.network(_imageUrl);
    //MIRAR CUADERNO:
    //  - Comprobar que la foto existe
    //  - Circullito de carga
    //}

    // Future<dynamic> userInfo = getInfo(_id);

    return Scaffold(
        drawer: MenuProvider(id: _id, currentPage: 'HomePage', user: user),
        backgroundColor: CustomColor.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 90.0,
          backgroundColor: CustomColor.backgroundColor,
          elevation: 0.0,
          actions: <Widget>[UserCard(id: _id, user: user)],
        ),
        body: ListView(
          //padding: EdgeInsets.all(10.0), //MoneyCardList(id: _id),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 7.0),
                child: Text('Mis cuentas',
                    style: TextStyle(
                        color: CustomColor.darkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_id)
                    .collection('bankAccounts')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allBankAccounts = snapshot.data;

                  if (snapshot.hasData) {
                    //return Text(allBankAccounts.docs[0].id);
                    // return Expanded(
                      return Container(
                        //child: Text('hola')
                        child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: allBankAccounts.docs.length,
                        itemBuilder: (context, index) {
                          return MoneyCard(
                              id: _id,
                              idCuentaBancaria: allBankAccounts.docs[index].id,
                              user: user);
                          },
                        ),
                      //)
                      
                    );
                  }

                  // final allFields = snapshot.data;
                  // if (snapshot.hasData) {
                  //   List<dynamic> cuentasBancarias = allFields['bankAccount'];
                  //   return Expanded(
                  //     child: ListView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: cuentasBancarias.length,
                  //       itemBuilder: (context, index) {
                  //         return MoneyCard(
                  //             id: _id,
                  //             idCuentaBancaria: cuentasBancarias[index],
                  //             user: user); //te has quedado aquí
                  //       },
                  //     ),
                  //   );
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_id)
                    .collection('bankAccounts')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allBankAccounts = snapshot.data;

                  if (snapshot.hasData) {
                    double suma = 0;
                    for (int i = 0; i < allBankAccounts.docs.length; i++) {
                      dynamic actual = allBankAccounts.docs[i];
                      suma += actual['Money'].toDouble();
                    }
                    return Card(
                      color: CustomColor.almostWhiteColor,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                              child: Text(
                                'Total:',
                                style: TextStyle(fontSize: 18.0),
                              )),
                          Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                              child: Text(
                                suma.toStringAsFixed(2) + ' €',
                                style: TextStyle(fontSize: 22.0),
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Divider(),
            SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_id)
                    .collection('transactions')
                    .orderBy('fecha')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allTransactions = snapshot.data;
                  List<dynamic> datos = [];
                  List<dynamic> dLunes = [];
                  List<dynamic> dMartes = [];
                  List<dynamic> dMiercoles = [];
                  List<dynamic> dJueves = [];
                  List<dynamic> dViernes = [];
                  List<dynamic> dSabado = [];
                  List<dynamic> dDomingo = [];

                  if (snapshot.hasData) {
                    for (int i = 0; i < allTransactions.docs.length; i++) {
                      dynamic movActual = allTransactions.docs[i];
                      Timestamp fecha = movActual['fecha'];

                      DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
                          fecha.microsecondsSinceEpoch);
                      dynamic cantidad = movActual['valor'];
                      if (cantidad < 0) {
                        int diaSemana = dt.weekday;
                        DateTime lunesPasado = DateTime.now()
                            .subtract(Duration(days: DateTime.now().weekday));

                        if (lunesPasado.isBefore(dt)) {
                          if (diaSemana == 1) {
                            dLunes.add(cantidad.abs());
                          }
                          if (diaSemana == 2) {
                            dMartes.add(cantidad.abs());
                          }
                          if (diaSemana == 3) {
                            dMiercoles.add(cantidad.abs());
                          }
                          if (diaSemana == 4) {
                            dJueves.add(cantidad.abs());
                          }
                          if (diaSemana == 5) {
                            dViernes.add(cantidad.abs());
                          }
                          if (diaSemana == 6) {
                            dSabado.add(cantidad.abs());
                          }
                          if (diaSemana == 7) {
                            dDomingo.add(cantidad.abs());
                          }
                        }
                      }
                    }
                    int diaSemanaActual = DateTime.now().weekday;
                    dynamic suma = 0;
                    for (int i = 1; i <= diaSemanaActual; i++) {
                      if (i == 1) {
                        suma = sumarDatosDia(lista: dLunes);
                      }
                      if (i == 2) {
                        suma = sumarDatosDia(lista: dMartes);
                      }
                      if (i == 3) {
                        suma = sumarDatosDia(lista: dMiercoles);
                      }
                      if (i == 4) {
                        suma = sumarDatosDia(lista: dJueves);
                      }
                      if (i == 5) {
                        suma = sumarDatosDia(lista: dViernes);
                      }
                      if (i == 6) {
                        suma = sumarDatosDia(lista: dSabado);
                      }
                      if (i == 7) {
                        suma = sumarDatosDia(lista: dDomingo);
                      }
                      datos.add(suma);
                    }

                    while (datos.length < 7) {
                      datos.add(0);
                    }
                    //return Container();
                    return GraphCard(lista: datos);

                    // return SizedBox(
                    //     child: ListView.builder(
                    //         padding: EdgeInsets.all(10.0),
                    //         physics: NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         scrollDirection: Axis.vertical,
                    //         itemCount: allTransactions.docs.length,
                    //         itemBuilder: (context, index) {
                    //           dynamic movActual = allTransactions.docs[index];
                    //           dynamic cantidad = movActual['valor'];
                    //           Timestamp fecha = movActual['fecha'];

                    //           DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
                    //               fecha.microsecondsSinceEpoch);
                    //           int diaSemana = dt.weekday;
                    //           String dia;

                    //           if (diaSemana == 0) {
                    //             dia = 'L';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'M';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'X';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'J';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'V';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'S';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'D';
                    //           }

                    //           return Container();
                    //         }));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_id)
                    .collection('transactions')
                    .orderBy('fecha')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allTransactions = snapshot.data;
                  List<dynamic> datos = [];
                  List<dynamic> dLunes = [];
                  List<dynamic> dMartes = [];
                  List<dynamic> dMiercoles = [];
                  List<dynamic> dJueves = [];
                  List<dynamic> dViernes = [];
                  List<dynamic> dSabado = [];
                  List<dynamic> dDomingo = [];

                  if (snapshot.hasData) {
                    for (int i = 0; i < allTransactions.docs.length; i++) {
                      dynamic movActual = allTransactions.docs[i];
                      Timestamp fecha = movActual['fecha'];

                      DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
                          fecha.microsecondsSinceEpoch);
                      dynamic cantidad = movActual['valor'];
                      if (cantidad > 0) {
                        int diaSemana = dt.weekday;
                        DateTime lunesPasado = DateTime.now()
                            .subtract(Duration(days: DateTime.now().weekday));

                        if (lunesPasado.isBefore(dt)) {
                          if (diaSemana == 1) {
                            dLunes.add(cantidad.abs());
                          }
                          if (diaSemana == 2) {
                            dMartes.add(cantidad.abs());
                          }
                          if (diaSemana == 3) {
                            dMiercoles.add(cantidad.abs());
                          }
                          if (diaSemana == 4) {
                            dJueves.add(cantidad.abs());
                          }
                          if (diaSemana == 5) {
                            dViernes.add(cantidad.abs());
                          }
                          if (diaSemana == 6) {
                            dSabado.add(cantidad.abs());
                          }
                          if (diaSemana == 7) {
                            dDomingo.add(cantidad.abs());
                          }
                        }
                      }
                    }
                    int diaSemanaActual = DateTime.now().weekday;
                    dynamic suma = 0;
                    for (int i = 1; i <= diaSemanaActual; i++) {
                      if (i == 1) {
                        suma = sumarDatosDia(lista: dLunes);
                      }
                      if (i == 2) {
                        suma = sumarDatosDia(lista: dMartes);
                      }
                      if (i == 3) {
                        suma = sumarDatosDia(lista: dMiercoles);
                      }
                      if (i == 4) {
                        suma = sumarDatosDia(lista: dJueves);
                      }
                      if (i == 5) {
                        suma = sumarDatosDia(lista: dViernes);
                      }
                      if (i == 6) {
                        suma = sumarDatosDia(lista: dSabado);
                      }
                      if (i == 7) {
                        suma = sumarDatosDia(lista: dDomingo);
                      }
                      datos.add(suma);
                    }

                    while (datos.length < 7) {
                      datos.add(0);
                    }
                    //return Container();
                    return Graph2Card(lista: datos);

                    // return SizedBox(
                    //     child: ListView.builder(
                    //         padding: EdgeInsets.all(10.0),
                    //         physics: NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         scrollDirection: Axis.vertical,
                    //         itemCount: allTransactions.docs.length,
                    //         itemBuilder: (context, index) {
                    //           dynamic movActual = allTransactions.docs[index];
                    //           dynamic cantidad = movActual['valor'];
                    //           Timestamp fecha = movActual['fecha'];

                    //           DateTime dt = DateTime.fromMicrosecondsSinceEpoch(
                    //               fecha.microsecondsSinceEpoch);
                    //           int diaSemana = dt.weekday;
                    //           String dia;

                    //           if (diaSemana == 0) {
                    //             dia = 'L';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'M';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'X';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'J';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'V';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'S';
                    //           }
                    //           if (diaSemana == 0) {
                    //             dia = 'D';
                    //           }

                    //           return Container();
                    //         }));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
                //PieChartCard(),
                //Pie2ChartCard(),
            SizedBox(height: 5.0),
            SafeArea(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_id)
                      .collection('transactions')
                      .orderBy('fecha')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final allTransactions = snapshot.data;
                    if (snapshot.hasData) {
                      if (allTransactions.docs.length < 31) {
                        return Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                  'No hay suficientes datos para mostrarte una predicción.'),
                            ));
                      } else {
                        return FutureBuilder<Prediction>(
                          future: pred,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.prediction != null) {
                                List<dynamic> datosPrediccion = [];
                                List<dynamic> datosPrediccionAux = [];
                                List<dynamic> datosHoy = [];
                                double sumaHoy = 0;

                                List<String> datosString = snapshot
                                    .data.prediction
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')
                                    .split(',');
                                //datosPrediccion = snapshot.data.prediction.replaceAll('[', '').replaceAll(']', '').split(',');
                                datosString.forEach((element) {
                                  datosPrediccion.add(double.parse(
                                      double.parse(element).toStringAsFixed(2)));
                                  //element = double.parse(element);
                                });
                                datosHoy = datosPrediccion.sublist(
                                    0, datosPrediccion.length - 13);

                                datosPrediccion.forEach((element) {
                                  sumaHoy += element;
                                });
                                datosPrediccionAux = datosPrediccion
                                    .sublist(datosPrediccion.length - 13);
                                datosPrediccion = [];
                                datosPrediccion.add(double.parse(sumaHoy.toStringAsFixed(2)));
                                datosPrediccionAux.forEach((element) {
                                  datosPrediccion.add(double.parse(element.toString()));
                                });
                                return LineChartCard(lista: datosPrediccion);
                                //return Text(snapshot.data.prediction);
                              }
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner.
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
        bottomNavigationBar: CustomUserBottomNavigation(index: 0, userId: _id, user: user),
    );
  }
}

dynamic sumarDatosDia({List<dynamic> lista}) {
  dynamic suma = 0;
  for (int i = 0; i < lista.length; i++) {
    suma = suma + lista[i];
  }
  return suma;
}

getInfo(String id) async {
  return await FirebaseFirestore.instance.collection('users').doc(id).get();
}

Future<void> reloadPage() {
  Completer<Null> completer = new Completer<Null>();
  Timer timer = new Timer(new Duration(seconds: 3), () {
    completer.complete();
  });
  return completer.future;
}
