import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/custom/customFamilyBottomNav.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class FamilyBalancePage extends StatefulWidget {
  FamilyBalancePage(
      {Key key,
      @required this.familyId,
      @required this.user,
      @required this.userId})
      : super(key: key);
  final String familyId;
  final DocumentSnapshot user;
  final String userId;

  @override
  _FamilyBalancePageState createState() =>
      _FamilyBalancePageState(this.familyId, this.user, this.userId);
}

class _FamilyBalancePageState extends State<FamilyBalancePage> {
  final String familyId;
  final DocumentSnapshot user;
  final String userId;
  _FamilyBalancePageState(this.familyId, this.user, this.userId);

  ScrollController _scrollController = new ScrollController();

  List<int> listaNumeros = [];
  int ultimoItem = 0;

  @override
  void initState() {
    super.initState();

    agregar10();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('asdfas');
        agregar10();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Listas'),
      // ),
      key: _scaffoldKey,
      drawer: MenuProvider(id: userId, user: user, currentPage: 'FamilyPage'),
      backgroundColor: CustomColor.mainColor,
      body: Stack(children: [
        CustomBackgroundAll(),
        SingleChildScrollView(
            child: Column(children: [
          SafeArea(
              top: false,
              child: Container(
                height: _height * 0.077,
              )),
          Container(
            child: Text('Balance familiar',
                style: TextStyle(
                    fontSize: 20.0,
                    color: CustomColor.darkColor,
                    fontWeight: FontWeight.bold)),
            padding: EdgeInsets.only(),
          ),
          Container(
              child: Column(children: [
            SafeArea(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('families')
                      .doc(familyId)
                      .collection('transactions')
                      .orderBy('fecha', descending: true)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final allTransactions = snapshot.data;
                    if (snapshot.hasData) {
                      return SizedBox(
                          child: ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: allTransactions.docs.length,
                              itemBuilder: (context, index) {
                                dynamic movActual = allTransactions.docs[index];
                                String memberId = movActual['userId'];
                                dynamic cantidad = movActual['valor'];

                                return SafeArea(
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(memberId)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        final allFields = snapshot.data;
                                        if (snapshot.hasData) {

                                          // List<dynamic> categorias =
                                          //     movActual['categorias'] == null ? '' : movActual['categorias'];
                                          String concepto = movActual['concepto'] == null ? '-' : movActual['concepto'];
                                          String descripcion =
                                              movActual['descripcion'] == null ? '-' : movActual['descripcion'];
                                          String destorigen =
                                              movActual['destorigen'] == null ? '-' : movActual['destorigen'];
                                          Timestamp fecha = movActual['fecha'];
                                          bool isSecret = movActual['isSecret'];

                                          if (isSecret == false) {
                                            String nombre = allFields['Nombre'];
                                            String apellidos = allFields['Apellidos'];

                                            return GestureDetector(
                                              child: Container(
                                                  padding: EdgeInsets.zero,
                                                  child: ListTile(
                                                    title: Text(
                                                        cantidad.abs().toString()),
                                                    subtitle: Text(
                                                        nombre + ' ' + apellidos),
                                                    leading: cantidad > 0
                                                        ? Icon(
                                                            Icons
                                                                .arrow_drop_up_rounded,
                                                            color: Colors.green,
                                                            size: 35.0,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .arrow_drop_down_rounded,
                                                            color: Colors.red,
                                                            size: 35.0),
                                                  )),
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => new AlertDialog(
                                                        title: Text('Información'),
                                                        content: Container(
                                                            child: cantidad > 0
                                                                ? Text('Usuario:   ' +
                                                                    nombre
                                                                        .toUpperCase() +
                                                                    ' ' +
                                                                    apellidos
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Concepto:   ' +
                                                                    concepto
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Descripción:   ' +
                                                                    descripcion +
                                                                    '\n' +
                                                                    'Origen:   ' +
                                                                    destorigen
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Fecha:   ' +
                                                                    fecha
                                                                        .toDate()
                                                                        .day
                                                                        .toString() +
                                                                    '/' +
                                                                    fecha
                                                                        .toDate()
                                                                        .month
                                                                        .toString() +
                                                                    '/' +
                                                                    fecha
                                                                        .toDate()
                                                                        .year
                                                                        .toString() +
                                                                    '\n' +
                                                                    'Valor:   ' +
                                                                    cantidad
                                                                        .abs()
                                                                        .toString())
                                                                : Text('Usuario:   ' +
                                                                    nombre
                                                                        .toUpperCase() +
                                                                    ' ' +
                                                                    apellidos
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Concepto:   ' +
                                                                    concepto
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Descripción:   ' +
                                                                    descripcion +
                                                                    '\n' +
                                                                    'Destino:   ' +
                                                                    destorigen
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Fecha:   ' +
                                                                    fecha
                                                                        .toDate()
                                                                        .day
                                                                        .toString() +
                                                                    '/' +
                                                                    fecha
                                                                        .toDate()
                                                                        .month
                                                                        .toString() +
                                                                    '/' +
                                                                    fecha
                                                                        .toDate()
                                                                        .year
                                                                        .toString() +
                                                                    '\n' +
                                                                    'Valor:   ' +
                                                                    cantidad
                                                                        .abs()
                                                                        .toString()))));
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }
                                        return Container();
                                      }),
                                );
                                //return FamilyMembersCard(memberId: catActual[index], user: user);
                              }));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ]))
        ])),
        IconButton(
          padding: EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ]),
      bottomNavigationBar: CustomFamilyBottomNavigation(
        index: 2,
        userId: userId,
        familyId: familyId,
        user: user,
      ),
    );
  }

  Widget _crearLista() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: listaNumeros.length,
      itemBuilder: (BuildContext context, int index) {
        final imagen = listaNumeros[index];
        return FadeInImage(
            placeholder: AssetImage('assets/google-logo.png'),
            image:
                NetworkImage('https://picsum.photos/500/300/?image=$imagen'));
      },
    );
  }

  agregar10() {
    for (var i = 1; i < 10; i++) {
      ultimoItem++;
      listaNumeros.add(ultimoItem);
    }
    setState(() {});
  }
}
