import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newExpense_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

import 'newIncome_page.dart';

class CategoriesPages extends StatefulWidget {
  CategoriesPages(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.title,
      @required this.familyId,
      @required this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String title;
  final String familyId;

  final double cantidad;
  final String concepto;
  final String destinatario;
  final String descripcion;
  final bool isSecret;

  @override
  _CategoriesPagesState createState() => _CategoriesPagesState(
      this.id,
      this.user,
      this.title,
      this.familyId,
      this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret);
}

class _CategoriesPagesState extends State<CategoriesPages> {
  _CategoriesPagesState(
      this.id,
      this.user,
      this.title,
      this.familyId,
      this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String id;
  final DocumentSnapshot user;
  final String title;
  final String familyId;

  final double cantidad;
  final String concepto;
  final String destinatario;
  final String descripcion;
  final bool isSecret;

  bool _isChecked = false;
  dynamic elegido;
  bool primeraVez = false;

  dynamic cat;

  List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List<bool>.filled(20, false);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(id: id, currentPage: 'NewExpensePage', user: user),
      //backgroundColor: Colors.teal[50],
      body: Stack(
        children: [
          CustomBackgroundAll(),
          SingleChildScrollView(
              child: Column(
            children: [
              SafeArea(
                  top: false,
                  child: Container(
                    height: _height * 0.1,
                  )),
              Card(
                  //width: _width * 0.9,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 20.0),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   boxShadow: <BoxShadow>[
                  //     BoxShadow(
                  //         color: Colors.black26, //CustomColor.shadowColor,
                  //         blurRadius: 10.0,
                  //         spreadRadius: 1.0,
                  //         offset: Offset(0.0, 5.0)),
                  //   ],
                  // ),
                  child: Container(
                    width: _width * 0.9,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15.0),
                        Text('Añade tu nuevo ' + title,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColor.mainColor,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          child: Text('Selecciona categorías:'),
                          alignment: Alignment.topLeft,
                        ),
                        SafeArea(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(id)
                                  .collection('categories')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                final allCategories = snapshot.data;
                                if (snapshot.hasData) {
                                  cat = allCategories.docs;
                                  return SizedBox(
                                      width: _width * 0.9,
                                      child: ListView.builder(
                                          padding: EdgeInsets.all(10.0),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: allCategories.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot catActual =
                                                allCategories.docs[index];
                                            String nombre = catActual['Name'];
                                            Color color =
                                                Color(catActual['Color']);
                                            _isChecked = selected[index];
                                            return CheckboxListTile(
                                              value: _isChecked,
                                              onChanged: elegido ==
                                                          cat[index].id ||
                                                      elegido == null
                                                  ? (newValue) {
                                                      setState(() {
                                                        _isChecked = newValue;
                                                        selected[index] =
                                                            _isChecked;
                                                        primeraVez = true;
                                                        if (elegido ==
                                                            cat[index].id) {
                                                          elegido = null;
                                                        } else {
                                                          elegido =
                                                              cat[index].id;
                                                        }
                                                      });
                                                    }
                                                  : null,
                                              title: Row(children: [
                                                Text(nombre),
                                                Expanded(child: Container()),
                                                Container(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  color: color,
                                                ),
                                                SizedBox(width: 30.0)
                                              ]),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                            );
                                          }));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectBankAccountPage(
                                        categoria: [elegido],
                                        id: id,
                                        familyId: familyId,
                                        user: user,
                                        title: title,
                                        cantidad: cantidad,
                                        concepto: concepto,
                                        destinatario: destinatario,
                                        descripcion: descripcion,
                                        isSecret: isSecret,
                                      )),
                            );
                          },
                          child: Text('Siguiente'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColor.mainColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.teal[10]),
                              //side: MaterialStateProperty.all<BorderSide>(),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                        ),
                        SizedBox(height: 15.0)
                      ],
                    ),
                  ))
            ],
          )),
          IconButton(
            padding: EdgeInsets.only(top: 60),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectBankAccountPage extends StatefulWidget {
  SelectBankAccountPage(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.title,
      @required this.familyId,
      @required this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret,
      this.categoria})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String title;
  final String familyId;

  final double cantidad;
  final String concepto;
  final String destinatario;
  final String descripcion;
  final bool isSecret;
  final List<dynamic> categoria;

  @override
  _SelectBankAccountPageState createState() => _SelectBankAccountPageState(
      this.id,
      this.user,
      this.title,
      this.familyId,
      this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret,
      this.categoria);
}

class _SelectBankAccountPageState extends State<SelectBankAccountPage> {
  _SelectBankAccountPageState(
      this.id,
      this.user,
      this.title,
      this.familyId,
      this.cantidad,
      this.concepto,
      this.destinatario,
      this.descripcion,
      this.isSecret,
      this.categoria);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String id;
  final DocumentSnapshot user;
  final String title;
  final String familyId;
  final List<dynamic> categoria;

  final double cantidad;
  final String concepto;
  final String destinatario;
  final String descripcion;
  final bool isSecret;

  bool _isChecked = false;
  dynamic elegido;
  bool primeraVez = false;

  String nombreBA;
  dynamic numeroBA;
  dynamic dineroBA;

  dynamic ba;

  List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List<bool>.filled(20, false);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(id: id, currentPage: 'NewExpensePage', user: user),
      //backgroundColor: Colors.teal[50],
      body: Stack(
        children: [
          CustomBackgroundAll(),
          SingleChildScrollView(
              child: Column(
            children: [
              SafeArea(
                  top: false,
                  child: Container(
                    height: _height * 0.1,
                  )),
              Card(
                  //width: _width * 0.9,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 20.0),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   boxShadow: <BoxShadow>[
                  //     BoxShadow(
                  //         color: Colors.black26, //CustomColor.shadowColor,
                  //         blurRadius: 10.0,
                  //         spreadRadius: 1.0,
                  //         offset: Offset(0.0, 5.0)),
                  //   ],
                  // ),
                  child: Container(
                    width: _width * 0.9,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15.0),
                        Text('Añada su nuevo ' + title,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColor.mainColor,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          child: Text('Seleccione una cuenta bancaria:'),
                          alignment: Alignment.topLeft,
                        ),
                        SafeArea(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(id)
                                  .collection('bankAccounts')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                final allBA = snapshot.data;
                                if (snapshot.hasData) {
                                  ba = allBA.docs;
                                  return SizedBox(
                                      width: _width * 0.9,
                                      child: ListView.builder(
                                          padding: EdgeInsets.all(10.0),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: allBA.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            DocumentSnapshot docAct =
                                                allBA.docs[index];
                                            nombreBA = docAct['Name'] == null
                                                ? ''
                                                : docAct['Name'];
                                            numeroBA = docAct['AccountNumber'];
                                            dineroBA = docAct['Money'];
                                            _isChecked = selected[index];

                                            if (nombreBA != '') {
                                              return CheckboxListTile(
                                                value: _isChecked,
                                                onChanged: elegido ==
                                                            ba[index].id ||
                                                        elegido == null
                                                    ? (newValue) {
                                                        setState(() {
                                                          _isChecked = newValue;
                                                          selected[index] =
                                                              _isChecked;
                                                          primeraVez = true;
                                                          if (elegido ==
                                                              ba[index].id) {
                                                            elegido = null;
                                                          } else {
                                                            elegido =
                                                                ba[index].id;
                                                          }
                                                        });
                                                      }
                                                    : null,
                                                title: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                  Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text(nombreBA, textAlign: TextAlign.right,)),
                                                  SizedBox(width: 30.0)
                                                ]),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              );
                                            } else {
                                              return CheckboxListTile(
                                                value: _isChecked,
                                                onChanged: elegido ==
                                                            ba[index].id ||
                                                        elegido == null
                                                    ? (newValue) {
                                                        setState(() {
                                                          _isChecked = newValue;
                                                          selected[index] =
                                                              _isChecked;
                                                          primeraVez = true;
                                                          if (elegido ==
                                                              ba[index].id) {
                                                            elegido = null;
                                                          } else {
                                                            elegido =
                                                                ba[index].id;
                                                          }
                                                        });
                                                      }
                                                    : null,
                                                title: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: Text(numeroBA.toString())),
                                                      SizedBox(width: 30.0)
                                                    ]),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              );
                                            }
                                          }));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {
                            if (elegido == null) {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                          title: Text(
                                              'Atención'),
                                          content: Text('Es necesario que registre el gasto en una cuenta bancaria'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    'Aceptar'))
                                          ]));
                            } else {
                              saveButton(
                                  selected: elegido,
                                  id: id,
                                  familyId: familyId,
                                  user: user,
                                  cantidad: cantidad,
                                  concepto: concepto,
                                  destinatario: destinatario,
                                  descripcion: descripcion,
                                  isSecret: isSecret,
                                  categoria: categoria,
                                  dineroActual:
                                      double.parse(dineroBA.toString()));
                            }
                          },
                          child: Text('Guardar ' + title),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColor.mainColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.teal[10]),
                              //side: MaterialStateProperty.all<BorderSide>(),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                        ),
                        SizedBox(height: 15.0)
                      ],
                    ),
                  ))
            ],
          )),
          IconButton(
            padding: EdgeInsets.only(top: 60),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  saveButton(
      {String selected,
      String id,
      String familyId,
      DocumentSnapshot user,
      double cantidad,
      String concepto,
      String destinatario,
      String descripcion,
      bool isSecret,
      dynamic categoria,
      double dineroActual}) async {
    //El gasto es negativo

    // List<String> categorias = [];
    // for (int i = 0; i < selected.length; i++) {
    //   if (selected[i]) {
    //     categorias.add(cat[i].id);
    //   }
    // }

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions');
    DocumentReference doc = await db.add({
      'categorias': categoria,
      'concepto': concepto,
      'descripcion': descripcion,
      'destorigen': destinatario,
      'fecha': date,
      'isSecret': isSecret,
      'userId': id,
      'valor': cantidad,
    });

    final dbTotal = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('bankAccounts')
        .doc(selected);

      await dbTotal
          .update({'Money': dineroActual + double.parse(cantidad.toString())});
  
    bool todoCorrecto = false;

    dynamic userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('transactions')
        .doc(doc.id);

    String userConf = 'false';
    userConf =
        await getTransaction(transactionId: doc.id, id: id, type: 'users');

    if (userConf == 'true') {
      if (familyId != "") {
        await FirebaseFirestore.instance
            .collection('families')
            .doc(familyId)
            .collection('transactions')
            .doc(doc.id)
            .set({
          'categorias': selected,
          'concepto': concepto,
          'descripcion': descripcion,
          'destorigen': destinatario,
          'fecha': date,
          'isSecret': isSecret,
          'userId': id,
          'valor': cantidad,
        });

        dynamic familyRef = FirebaseFirestore.instance
            .collection('families')
            .doc(familyId)
            .collection('transactions')
            .doc(doc.id);

        String familyConf = 'false';
        familyConf = await getTransaction(
            transactionId: doc.id, id: familyId, type: 'families');

        if (familyConf == 'true') {
          todoCorrecto = true;
        }
      } else {
        todoCorrecto = true;
      }
    }

    // userRef.get().then((docSnapshot) {
    //   if (docSnapshot.exists) {
    //     userConf = true;
    //   }
    // });
    // familyRef.get().then((docSnapshot) {
    //   if (docSnapshot.exists) {
    //     familyConf = true;
    //   }
    // });

    if (todoCorrecto == true) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Se ha guardado el ' + title),
          content: Text(
              'El registro del ' + title + ' se ha guardado correctamente.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(id: id, user: user),
                    ),
                  );
                },
                child: Text('Volver a la página principal')),
            TextButton(
                onPressed: () {
                  if (title == 'gasto') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewExpensePage(
                            id: id, familyId: familyId, user: user),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewIncomePage(
                            id: id, familyId: familyId, user: user),
                      ),
                    );
                  }
                },
                child: Text('Añadir un nuevo ' + title))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Ha habido un error'),
          content: Text('Se ha producido un error en el registro del ' +
              title +
              '. Inténtelo más tarde o contacte con nosotros.\nDisculpe las molestias.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(id: id, user: user),
                  ),
                );
              },
              child: Text('Volver a la página principal'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.darkColor)),
            ),
            TextButton(
              onPressed: () {
                if (title == 'gasto') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewExpensePage(
                          id: id, familyId: familyId, user: user),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewIncomePage(id: id, familyId: familyId, user: user),
                    ),
                  );
                }
              },
              child: Text('Añadir un nuevo ' + title),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.darkColor)),
            )
          ],
        ),
      );
    }

    // mostrarVentana(idMov: doc.id);
  }
}
