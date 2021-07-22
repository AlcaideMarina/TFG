import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/backgrounds/customUserBottomNav.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class BalancePage extends StatefulWidget {
  BalancePage({Key key, @required this.id, @required this.user});
  final String id;
  final DocumentSnapshot user;

  @override
  _BalancePageState createState() =>
      _BalancePageState(id: this.id, user: this.user);
}

class _BalancePageState extends State<BalancePage> {
  final String id;
  final DocumentSnapshot user;
  _BalancePageState({this.id, this.user});
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
      drawer: MenuProvider(id: id, user: user, currentPage: 'FamilyPage'),
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
            child: Text('Balance individual',
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
                        .collection('users')
                        .doc(id)
                        .collection('transactions')
                        .orderBy('fecha', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      final allTransactions = snapshot.data;
                      if (snapshot.hasData) {
                        if (allTransactions.docs.length == 0) {
                          return Container(
                            child: Text(
                              'No hay nada que mostrar...',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            padding: EdgeInsets.only(top: 100.0),
                          );
                        } else {
                          // return SafeArea(
                          //     child: StreamBuilder(
                          //         stream: FirebaseFirestore.instance
                          //             .collection('users')
                          //             .doc(id)
                          //             .collection('transactions')
                          //             .orderBy('fecha', descending: true)
                          //             .snapshots(),
                          //         builder: (BuildContext context,
                          //             AsyncSnapshot<dynamic> snapshot) {
                          //           final allTransactions = snapshot.data;
                          //           if (snapshot.hasData) {
                                      return Container(
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(10.0),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              allTransactions.docs.length,
                                          itemBuilder: (context, index) {
                                            dynamic movActual =
                                                allTransactions.docs[index];
                                                print(movActual.id);
                                            dynamic cantidad =
                                                movActual['valor'];
                                            List<dynamic> categorias =
                                                movActual['categorias'] == null
                                                    ? ''
                                                    : movActual['categorias'];
                                            String concepto =
                                                movActual['concepto'] == null
                                                    ? '-'
                                                    : movActual['concepto'];
                                            String descripcion =
                                                movActual['descripcion'] == null
                                                    ? '-'
                                                    : movActual['descripcion'];
                                            String destorigen =
                                                movActual['destorigen'] == null
                                                    ? '-'
                                                    : movActual['destorigen'];
                                            Timestamp fecha =
                                                movActual['fecha'];

                                            return GestureDetector(
                                              child: Container(
                                                  padding: EdgeInsets.zero,
                                                  child: ListTile(
                                                    title: Text(cantidad
                                                        .abs()
                                                        .toString()),
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
                                                        title:
                                                            Text('Información'),
                                                        content: Container(
                                                            child: cantidad > 0
                                                                ? Text('Concepto:   ' +
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
                                                                : Text('Concepto:   ' +
                                                                    concepto
                                                                        .toUpperCase() +
                                                                    '\n' +
                                                                    'Descripción:   ' +
                                                                    descripcion
                                                                        .toUpperCase() +
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
                                          },
                                        ),
                                      );

                                      /* if (isSecret == false) {
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
                                                                descripcion
                                                                    .toUpperCase() +
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
                                                                descripcion
                                                                    .toUpperCase() +
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
                                      }*/
                                  //   }
                                  //   return Center(
                                  //       child: CircularProgressIndicator());
                                  // }
                                  // )
                                  // );

                          //return FamilyMembersCard(memberId: catActual[index], user: user);

                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))
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
      bottomNavigationBar: CustomUserBottomNavigation(
        index: 1,
        userId: id,
        //familyId: familyId,
        user: user,
      ),
    );
  }
}
