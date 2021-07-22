import 'package:auth/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customFamilyBottomNav.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/card/chart/familyPieChart_card.dart';
import 'package:homeconomy/src/card/single/familyMoney_card.dart';
import 'package:homeconomy/src/card/single/family_card.dart';
import 'package:homeconomy/src/card/chart/pieChart_card.dart';
import 'package:homeconomy/src/card/single/user_card.dart';
import 'package:homeconomy/src/get/getUser.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/pages/newFamily_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';
import 'package:homeconomy/src/card/chart/graph_card.dart';
import 'package:homeconomy/src/card/single/money_card.dart';
import 'package:homeconomy/custom/customColor.dart';

import 'package:homeconomy/src/pages/login_page.dart';

class FamilyPage extends StatefulWidget {
  FamilyPage(
      {@required this.familyId, @required this.user, @required this.userId});
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  @override
  _FamilyPageState createState() => _FamilyPageState(familyId, user, userId);
}

class _FamilyPageState extends State<FamilyPage> {
  String _name = 'loading...';
  String _surname = 'loading...';
  String _imageUrl = 'assets/random_user.png';
  Image _image;
  int _nBA;

  DocumentSnapshot getUser;

  @override
  void initState() {
    super.initState();
  }

  _FamilyPageState(this._familyId, this.user, this._userId);
  final String _userId;
  final DocumentSnapshot user;
  final String _familyId;
  // final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

    Future<dynamic> familyInfo;
    if (_familyId != "") {
      familyInfo = getFamilyInfo(_familyId);
    }

    final customBackground = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [CustomColor.mainColor, CustomColor.shadowColor])),
    );

    if (_familyId == "") {
      return Scaffold(
        key: _scaffoldKey,
        drawer:
            MenuProvider(id: _userId, user: user, currentPage: 'FamilyPage'),
        backgroundColor: CustomColor.mainColor,
        // appBar: AppBar(
        //   toolbarHeight: 90.0,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,

        //   // actions: <Widget>[
        //   //   FamilyCard(familyId: _id, familyDocument: userInfo)
        //   // ],
        // ),
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
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    children: [
                      Text(
                          'Vaya... parece que aún no formas parte de ninguna familia...'),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewFamilyPage(id: _userId, user: user, crear: false)),
                          );
                        },
                        child: Text('Únete a una familia'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColor.mainColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor: MaterialStateProperty.all<Color>(
                              CustomColor.shadowColor),
                          //side: MaterialStateProperty.all<BorderSide>(),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(30, 15, 30, 15)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(_width * 0.5, 40.0)),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text('- o -'),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewFamilyPage(id: _userId, user: user, crear: true,)),
                          );
                        },
                        child: Text('Crea una familia'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColor.mainColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor: MaterialStateProperty.all<Color>(
                              CustomColor.shadowColor),
                          //side: MaterialStateProperty.all<BorderSide>(),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(30, 15, 30, 15)),

                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(_width * 0.5, 40.0)),
                        ),
                      ),
                      SizedBox(height: 7.0)
                    ],
                  ),
                ),
              ),
            ])),
            IconButton(
              padding:
                  EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
        ),

        //     ListView(
        //       padding: EdgeInsets.all(10.0), //MoneyCardList(id: _id),
        //       children: <Widget>[
        //
        //       ],
        //     ),
        //   );
      );
    } else {
      ////////////////////////////////////////////////////////////////////////////////////////////
      return Scaffold(
        key: _scaffoldKey,
        drawer:
            MenuProvider(id: _userId, user: user, currentPage: 'FamilyPage'),
        backgroundColor: CustomColor.backgroundColor,
        // appBar: AppBar(
        //   toolbarHeight: 90.0,
        //   backgroundColor: CustomColor.backgroundColor,
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     FamilyCard(familyId: _familyId)
        //   ],
        // ),
        body: Stack(
          children: [
            ListView(children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0), //MoneyCardList(id: _id),

                  child: SafeArea(
                    //child: ListView(
                    // ESTO FALTA familyDocument,: user
                    child: FamilyCard(
                      familyId: _familyId,
                      familyDocument: user,
                    ),
                  )),
              Container(child: Text('Cuentas familiares', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColor.darkColor),), padding: EdgeInsets.all(10.0)),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0), //MoneyCardList(id: _id),

                  child: SafeArea(
                    //child: ListView(
                    // ESTO FALTA familyDocument,: user
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('families')
                          .doc(_familyId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        final allFields = snapshot.data;
                        if (snapshot.hasData) {
                          List<dynamic> miembros = allFields['members'];

                          return Container(
                            child: ListView.builder(
                                
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                //itemExtent: 90,
                                itemCount: miembros.length,
                                itemBuilder: (context, index) {
                                  String userActual = miembros[index];

                                  return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userActual)
                                        .collection('bankAccounts')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      dynamic allDocuments = snapshot.data;
                                      if (snapshot.hasData) {
                                        return Container(
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                //itemExtent: 90,
                                                itemCount: allDocuments.docs.length,
                                                itemBuilder: (context, index) {
                                                  dynamic docActual =
                                                      allDocuments.docs[index].id;
                                                  return FamilyMoneyCard(
                                                      id: userActual,
                                                      idCuentaBancaria:
                                                          docActual,
                                                      user: user);
                                                }));
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  );
                                }),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }

                        // final allDocuments = snapshot.data;
                        // if (snapshot.hasData) {

                        //   return Container(
                        //     child: ListView.builder(
                        //       physics: NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.vertical,
                        //       itemCount: allDocuments.docs.length,
                        //       itemBuilder: (context, index) {
                        //         return MoneyCard(
                        //             id: _userId,
                        //             idCuentaBancaria: allDocuments.docs[index].id,
                        //             user: user);
                        //       },
                        //     ),
                        //   );
                        // } else {
                        //   return Center(child: CircularProgressIndicator());
                        // }
                      },
                    ),
                  )),
              //),
              Divider(),
              SizedBox(
                height: 3.0,
              ),
              // Container(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 10.0), //MoneyCardList(id: _id),
              //     child: SafeArea(
              //       //child: ListView(

              //       child: GraphCard(),
              //     )),
              SizedBox(
                height: 3.0,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0), //MoneyCardList(id: _id),
                  child: SafeArea(
                    //child: ListView(

                    child: Container() //PieChartCard(),
                  )),
               SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('families')
                    .doc(_familyId)
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
                    return Container(child:GraphCard(lista: datos),
                      padding: EdgeInsets.all(10.0)
                    );

                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
              SizedBox(
                height: 3.0,
              ),
              Container(
              //margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0), //MoneyCardList(id: _id),
                  child: SafeArea(
                      //child: ListView(

                      // child: FamilyPieChart()
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('families')
                            .doc(_familyId)
                            .snapshots(),
                        builder: (context, snapshot){
                          final allFields = snapshot.data;
                          Map<dynamic, dynamic> mapMiembros = new Map();
                          if(snapshot.hasData) {
                            List<dynamic> miembrosGrafico = allFields['members'];
                            dynamic suma = 0;
                            miembrosGrafico.forEach((element) {
                              mapMiembros[element] = 0;
                            });
                          return SafeArea(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('families')
                                  .doc(_familyId)
                                  .collection('transactions')
                                  .orderBy('fecha', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                final allDocuments = snapshot.data;
                                
                                if (snapshot.hasData) {
                          
                                  for(int i = 0; i < allDocuments.docs.length; i++) {
                                    
                                    dynamic docActual = allDocuments.docs[i];
                                    dynamic valor = docActual['valor'];
                                    dynamic usuarioGrafico = docActual['userId'];

                                    if(valor < 0) {
                                      mapMiembros[usuarioGrafico] = mapMiembros[usuarioGrafico] + valor.abs();
                                      suma = suma + valor.abs();
                                    }
                                  }
                                  return FamilyPieChart(mapMiembros: mapMiembros, miembrosGrafico: miembrosGrafico, suma: suma);
                                }
                                else {
                                  return Center(child: CircularProgressIndicator());
                                }
                          
                          
                              },
                            ),
                          );}
                         
                          else {
                            return Center(child: CircularProgressIndicator());
                          }}
                        ),
                      ),
                  ),
              SizedBox(
                height: 20.0,
              )
            ]),
            IconButton(
              padding:
                  EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomFamilyBottomNavigation(
          index: 1,
          userId: _userId,
          familyId: _familyId,
          user: user,
        ),
      );
    }
  }

  getFamilyInfo(String id) async {
    try {
      return await FirebaseFirestore.instance
          .collection('families')
          .doc(id)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }
}

dynamic sumarDatosDia({List<dynamic> lista}) {
  dynamic suma = 0;
  for (int i = 0; i < lista.length; i++) {
    suma = suma + lista[i];
  }
  return suma;
}