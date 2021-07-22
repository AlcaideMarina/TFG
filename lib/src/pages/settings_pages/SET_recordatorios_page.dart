import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundSettings.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/menu_pages/newExpense_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newIncome_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class RecordatoriosSettingsPage extends StatefulWidget {
  RecordatoriosSettingsPage(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId})
      : super(key: key);

  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _RecordatoriosSettingsPageState createState() =>
      _RecordatoriosSettingsPageState(id: id, user: user);
}

class _RecordatoriosSettingsPageState extends State<RecordatoriosSettingsPage> {
  final String id;
  final DocumentSnapshot user;
  final String familyId;
  _RecordatoriosSettingsPageState({this.id, this.user, this.familyId});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        CustomBackgroundSettings(),
        SingleChildScrollView(
          child: Column(
            children: [
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
                            'Recordatorios y avisos',
                            style: TextStyle(
                                fontSize: 23.0,
                                color: CustomColor.almostBlackColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ))),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: _width * 0.9,
                    //margin: EdgeInsets.fromLTRB(20.0, _height * 0.07, 20.0, 10.0),
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: _width,
                          // padding: EdgeInsets.only(
                          //     top: 10.0, left: 10.0, right: 10.0),
                          child: SafeArea(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(id)
                                    .collection('reminds')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  final allReminds = snapshot.data;
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                        child: ListView.builder(
                                            padding: EdgeInsets.all(0.0),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: allReminds.docs.length,
                                            itemBuilder: (context, index) {
                                              dynamic remActual =
                                                  allReminds.docs[index];
                                              String nombre = remActual['Nombre'];
                                              String periodicidad =
                                                  remActual['Periodicidad'];
                                              String fecha =
                                                  remActual['FechaRecordar'];
                                              dynamic precio =
                                                  remActual['Precio'];
                                              bool tipoGastoAct = remActual[
                                                  'TipoGasto']; // TRUE: Gasto, FALSE: Ingreso
                                              String recordatorio;
                                              String tipo;
                                              String d;
                                              String m;

                                              if (periodicidad != 'Semanal') {
                                                d = fecha.substring(0, 2);
                                                m = fecha.substring(3, 5);
                                              } else {
                                                d = fecha;
                                              }

                                              if (d.substring(0, 1) == '0') {
                                                d = d.substring(1);
                                              }
                                              recordatorio = obtenerRecordatorio(
                                                  periodicidad, d, m);

                                              if (tipoGastoAct == true) {
                                                tipo = 'gasto';
                                              } else {
                                                tipo = 'ingreso';
                                              }
                                              return Column(
                                                children: [
                                                  Card(
                                                      elevation: 10.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0),
                                                      ),
                                                      child: GestureDetector(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  5.0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                    nombre,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0)),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                              ),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              left:
                                                                                  10.0),
                                                                      child: Text(
                                                                          precio.toString() +
                                                                              ' €',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.0)),
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              15.0),
                                                                      child: Text(
                                                                          periodicidad,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.0)),
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                    ),
                                                                  ]),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                    'Recordatorio: ' +
                                                                        recordatorio,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0)),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                              ),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                    'Tipo: ' +
                                                                        tipo,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      color: tipo ==
                                                                              'gasto'
                                                                          ? Colors.red[
                                                                              900]
                                                                          : Colors
                                                                              .green[900],
                                                                    )),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => UpdateRecordatorio(id: id, user: user, familyId: familyId, recordatorioId: remActual.id)));
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .edit_rounded,
                                                                          color: CustomColor
                                                                              .almostBlackColor)),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (_) =>
                                                                                new AlertDialog(
                                                                                  title: new Text('Atención'),
                                                                                  content: new Text('Va a eliminar el recordatorio permanentemente, esta acción será permanente.\n¿Está seguro de esto?'),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      child: Text('Atrás', style: TextStyle(color: CustomColor.mainColor)),
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                    TextButton(
                                                                                      child: Text(
                                                                                        'Eliminar',
                                                                                        style: TextStyle(color: CustomColor.mainColor),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        String conf = await deleteRec(id: id, recordatorioId: remActual.id);
                                                                                        
                                                                                          //Navigator.of(context).pop();
                                                                                          new AlertDialog(title: conf == 'true' ? new Text('Recordatorio eliminado') : new Text('Error'), content: conf == 'true' ? new Text('El recordatorio seleccionado se ha eliminado correctamente.') : new Text('Se ha producido un error eliminando el recordatorio seleccionado. Por favor, inténtelo de nuevo.'), actions: <Widget>[
                                                                                            TextButton(
                                                                                              child: Text('Aceptar', style: TextStyle(color: CustomColor.mainColor)),
                                                                                              onPressed: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                            ),
                                                                                          ]);
                                                                                        
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .delete_rounded,
                                                                          color: CustomColor
                                                                              .almostBlackColor)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                      height:
                                                          5.0) // esto controla la separación entre los items
                                                ],
                                              );
                                            }));
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          )),
                    ),
                  )),
              SizedBox(height: 20.0)
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        splashColor: CustomColor.mainColor,
        backgroundColor: CustomColor.darkColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecordatorio(
                        id: id,
                        user: user,
                        familyId: familyId,
                      )));
        },
        tooltip: 'Añadir nuevo recordatorio',
        child: Icon(Icons.add),
      ),
    );
  }

  String obtenerMes(String numMes) {
    switch (numMes) {
      case '01':
        {
          return 'enero';
        }
        break;
      case '02':
        {
          return 'febrero';
        }
        break;
      case '03':
        {
          return 'marzo';
        }
        break;
      case '04':
        {
          return 'abril';
        }
        break;
      case '05':
        {
          return 'mayo';
        }
        break;
      case '06':
        {
          return 'junio';
        }
        break;
      case '07':
        {
          return 'julio';
        }
        break;
      case '08':
        {
          return 'agosto';
        }
        break;
      case '09':
        {
          return 'septiembre';
        }
        break;
      case '10':
        {
          return 'octubre';
        }
        break;
      case '11':
        {
          return 'noviembre';
        }
        break;
      case '12':
        {
          return 'diciembre';
        }
        break;
      default:
        {
          return 'Error';
        }
    }
  }

  String obtenerRecordatorio(String periodicidad, String dia, String mes) {
    switch (periodicidad) {
      case 'Diaria':
        {
          return 'cada día';
        }
      case 'Semanal':
        {
          return 'Los ' +
              dia.toLowerCase() +
              ' de cada semana'; // mirar si se podrían poner los días de la semana
        }
      case 'Mensual':
        {
          return 'día ' + dia + ' de cada mes';
        }
      case 'Anual':
        {
          return 'día ' + dia + ' de ' + mes + 'de cada año';
        }
      case 'Cada dos meses':
        {
          return 'día ' + dia + ' cada dos meses';
        }
      case 'Cada tres meses':
        {
          return 'día ' + dia + ' cada tres meses';
        }
      case 'Cada cuatro meses':
        {
          return 'día ' + dia + ' cada cuatro meses';
        }
      case 'Cada cinco meses':
        {
          return 'día ' + dia + ' cada cinco meses';
        }
      case 'Cada seis meses':
        {
          return 'día ' + dia + ' cada seis meses';
        }
      case 'Cada siete meses':
        {
          return 'día ' + dia + ' cada meses';
        }
      case 'Cada ocho meses':
        {
          return 'día ' + dia + ' cada ocho meses';
        }
      case 'Cada nueve meses':
        {
          return 'día ' + dia + ' cada nueve meses';
        }
      case 'Cada diez meses':
        {
          return 'día ' + dia + ' cada diez meses';
        }
      case 'Cada once meses':
        {
          return 'día ' + dia + ' cada once meses';
        }
      default:
        {
          return 'Error';
        }
    }
  }
}

class UpdateRecordatorio extends StatefulWidget {
  UpdateRecordatorio(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId,
      @required this.recordatorioId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;
  final String recordatorioId;

  @override
  _UpdateRecordatorioState createState() => _UpdateRecordatorioState(
      this.id, this.user, this.familyId, this.recordatorioId);
}

class _UpdateRecordatorioState extends State<UpdateRecordatorio> {
  final String id;
  final DocumentSnapshot user;
  final String familyId;
  final String recordatorioId;
  _UpdateRecordatorioState(
      this.id, this.user, this.familyId, this.recordatorioId);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String nombre;
  String fechaRecordar;
  String periodicidad;
  dynamic precio;
  bool tipoGasto;

  String d;
  String m;

  bool primeraVez = true;
  bool isAnual = false;
  bool isSemanal = false;
  bool isDiario = false;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tipoPeriodicidad = [
      'Diaria',
      'Semanal',
      'Mensual',
      'Anual',
      'Cada dos meses',
      'Cada tres meses',
      'Cada cuatro meses',
      'Cada cinco meses',
      'Cada seis meses',
      'Cada siete meses',
      'Cada ocho meses',
      'Cada nueve meses',
      'Cada diez meses',
      'Cada once meses'
    ];
    List<DropdownMenuItem<String>> _itemsPeriodicidad = [];
    _tipoPeriodicidad.forEach((element) {
      _itemsPeriodicidad
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<int> _listaNumDias = new List<int>.generate(31, (i) => i + 1);
    List<DropdownMenuItem<String>> _itemsNumDias = [];
    _itemsNumDias.add(DropdownMenuItem(child: Text('Día'), value: 'Día'));
    _listaNumDias.forEach((element) {
      _itemsNumDias.add(DropdownMenuItem(
          child: Text(element.toString()), value: element.toString()));
    });

    List<String> _listaDiasSemana = [
      'Día',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    List<DropdownMenuItem<String>> _itemsDiasSemana = [];
    _listaDiasSemana.forEach((element) {
      _itemsDiasSemana
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _listaMeses = [
      'Mes',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    List<DropdownMenuItem<String>> _itemsMeses = [];
    _listaMeses.forEach((element) {
      _itemsMeses.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposTipoGasto = ['Gasto', 'Ingreso'];
    List<DropdownMenuItem<String>> _itemsTipoGasto = [];
    _tiposTipoGasto.forEach((element) {
      _itemsTipoGasto
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

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
          child: Column(
            children: [
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
                            'Editar recordatorio',
                            style: TextStyle(
                                fontSize: 23.0,
                                color: CustomColor.almostBlackColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ))),
              SafeArea(child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(id)
                      .collection('reminds')
                      .doc(recordatorioId)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final allFields = snapshot.data;
                    if (snapshot.hasData) {
                      if (primeraVez) {
                        nombre = allFields['Nombre'];
                        fechaRecordar = allFields['FechaRecordar'];
                        periodicidad = allFields['Periodicidad'];
                        precio = allFields['Precio'];
                        tipoGasto = allFields['TipoGasto'];

                        if (periodicidad == 'Anual') {
                          isAnual = true;
                          isSemanal = false;
                          isDiario = false;
                        } else if (periodicidad == 'Semanal') {
                          isAnual = false;
                          isSemanal = true;
                          isDiario = false;
                        } else if (periodicidad == 'Diario') {
                          isAnual = false;
                          isSemanal = false;
                          isDiario = true;
                        } else {
                          isAnual = false;
                          isSemanal = false;
                          isDiario = false;
                        }
                        if (!isSemanal) {
                          d = fechaRecordar.substring(0, 2);
                          m = fechaRecordar.substring(3, 5);
                          if (d.substring(0, 1) == '0') {
                            d = d.substring(1, 2);
                          }
                          m = obtenerMes(m);
                        } else {
                          d = fechaRecordar;
                        }
                        primeraVez = false;
                      }

                      String strTipoGasto;
                      if (tipoGasto = true) {
                        strTipoGasto = 'Gasto';
                      } else {
                        strTipoGasto = 'Ingreso';
                      }

                      return Column(
                        children: [
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
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      labelText: 'Nombre del recordatorio',
                                    ),
                                    initialValue: nombre,
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
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      labelText: 'Precio (en €)',
                                    ),
                                    initialValue: precio.toString(),
                                    onChanged: (valor) {
                                      setState(() {
                                        precio = valor;
                                      });
                                    }),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(15.0)),
                                    ),
                                    filled: true,
                                    fillColor: CustomColor.almostWhiteColor,
                                  ),
                                  value: periodicidad,
                                  items: _itemsPeriodicidad,
                                  onChanged: (opt) {
                                    setState(() {
                                      d = 'Día';
                                      periodicidad = opt;
                                      if (periodicidad == 'Anual') {
                                        isAnual = true;
                                        isSemanal = false;
                                        isDiario = false;
                                      } else if (periodicidad == 'Semanal') {
                                        isAnual = false;
                                        isSemanal = true;
                                        isDiario = false;
                                      } else if (periodicidad == 'Diaria') {
                                        isAnual = false;
                                        isSemanal = false;
                                        isDiario = true;
                                      } else {
                                        isAnual = false;
                                        isSemanal = false;
                                        isDiario = false;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                // TextFormField(
                                //     textInputAction: TextInputAction.next,
                                //     keyboardType: TextInputType.number,
                                //     cursorColor: CustomColor.mainColor,
                                //     decoration: InputDecoration(
                                //       border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(15.0)),
                                //       labelText: 'Día para recordar',
                                //     ),
                                //     initialValue:
                                //         m == '00' ? d : d + ' de ' + m,
                                //     onChanged: (valor) {
                                //       setState(() {
                                //         fechaRecordar = valor;
                                //       });
                                //     }),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      width: _width * 0.38,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          enabled: !isDiario,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              15, 20.5, 0, 15),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: const BorderRadius
                                                    .all(
                                                const Radius.circular(15.0)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: const BorderRadius
                                                    .all(
                                                const Radius.circular(15.0)),
                                          ),
                                          filled: true,
                                          fillColor:
                                              CustomColor.almostWhiteColor,
                                          labelText: 'Día',
                                        ),
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16),
                                        value: !isDiario
                                                ? d
                                                : null,
                                        items: isSemanal
                                                ? _itemsDiasSemana
                                                : isDiario
                                                    ? []
                                                    : _itemsNumDias,
                                        onChanged: (opt) {
                                          setState(() {
                                            d = opt;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 15.0),
                                    Expanded(
                                      child: SizedBox(
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabled: isAnual,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 20.5, 0, 15),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  const Radius.circular(15.0)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  const Radius.circular(15.0)),
                                            ),
                                            filled: true,
                                            fillColor:
                                                CustomColor.almostWhiteColor,
                                            labelText: 'Mes',
                                          ),
                                          value: isAnual ? m : null,
                                          items: isAnual ? _itemsMeses : [],
                                          onChanged: (valor) {
                                            setState(() {
                                              m = valor;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(15.0)),
                                    ),
                                    filled: true,
                                    fillColor: CustomColor.almostWhiteColor,
                                  ),
                                  value: strTipoGasto,
                                  items: _itemsTipoGasto,
                                  onChanged: (opt) {
                                    setState(() {
                                      strTipoGasto = opt;
                                      if (strTipoGasto == 'Gasto') {
                                        tipoGasto = true;
                                      } else {
                                        tipoGasto = false;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(height: 30.0),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ChangeMyDataPage())
                                    // );
                                    // updateUser(
                                    //     _nombre,
                                    //     _apellidos,
                                    //     _laboral,
                                    //     _birth,
                                    //     _sexo,
                                    //     _numTelefono);
                                    updateRecordatorio(recordatorioId, nombre,
                                        precio, periodicidad, d, m, tipoGasto);
                                  },
                                  child: Text('Cambiar datos'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              CustomColor.mainColor),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              CustomColor.softColor),
                                      //side: MaterialStateProperty.all<BorderSide>(),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          EdgeInsets.fromLTRB(30, 15, 30, 15))),
                                ),
                                SizedBox(height: 10.0)
                              ]),
                            ),
                          ),
                          SizedBox(height: 30.0)
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(top: _height * 0.075, left: _width * 0.02),
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }

  updateRecordatorio(
      String recordatorioIdAct,
      String nombreAct,
      dynamic precioAct,
      String periodicidadAct,
      String diaAct,
      String mesAct,
      bool tipoGastoAct) async {
    String fechaRecordatorio;

    if (mesAct == 'Mes') {
      mesAct = '00';
    }
    if (diaAct.length == 1) {
      diaAct = '0' + diaAct;
    }

    if (periodicidad == 'Semanal') {
      fechaRecordatorio = diaAct;
    } else {
      fechaRecordatorio = diaAct + '/' + mesAct;
    }

    String conf = await updateRec(
        id: id,
        recordatorioId: recordatorioId,
        nombre: nombreAct,
        periodicidad: periodicidad,
        fechaRecordatorio: fechaRecordatorio,
        precio: precio,
        tipoGasto: tipoGastoAct);

    if (conf == 'true') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Datos guardados'),
                content: new Text('Los datos se han guardado correctamente.'),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK.',
                      style: TextStyle(color: CustomColor.mainColor),
                    ),
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Error'),
                content: new Text(
                    'Se ha producido un error al guardar los datos.\nMensaje de error: ' +
                        conf),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK.',
                      style: TextStyle(color: CustomColor.mainColor),
                    ),
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  )
                ],
              ));
    }
  }
}

String obtenerMes(String numMes) {
  switch (numMes) {
    case '01':
      {
        return 'Enero';
      }
      break;
    case '02':
      {
        return 'Febrero';
      }
      break;
    case '03':
      {
        return 'Marzo';
      }
      break;
    case '04':
      {
        return 'Abril';
      }
      break;
    case '05':
      {
        return 'Mayo';
      }
      break;
    case '06':
      {
        return 'Junio';
      }
      break;
    case '07':
      {
        return 'Julio';
      }
      break;
    case '08':
      {
        return 'Agosto';
      }
      break;
    case '09':
      {
        return 'Septiembre';
      }
      break;
    case '10':
      {
        return 'Octubre';
      }
      break;
    case '11':
      {
        return 'Noviembre';
      }
      break;
    case '12':
      {
        return 'Diciembre';
      }
      break;
    default:
      {
        return 'Mes';
      }
  }
}

class AddRecordatorio extends StatefulWidget {
  AddRecordatorio(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _AddRecordatorioState createState() =>
      _AddRecordatorioState(this.id, this.user, this.familyId);
}

class _AddRecordatorioState extends State<AddRecordatorio> {
  final String id;
  final DocumentSnapshot user;
  final String familyId;
  _AddRecordatorioState(this.id, this.user, this.familyId);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String nombre;
  String periodicidad = 'Periodicidad';
  String m = 'Mes';
  String d = 'Día';
  dynamic precio;
  bool tipoGasto;

  bool isAnual = false;
  bool isSemanal = false;
  bool isDiario = false;
  bool isPeriodicidad = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tipoPeriodicidad = [
      'Periodicidad',
      'Diaria',
      'Semanal',
      'Mensual',
      'Cada tres meses',
      'Cada seis meses',
      'Cada nueve meses',
      'Anual'
    ];
    List<DropdownMenuItem<String>> _itemsPeriodicidad = [];
    _tipoPeriodicidad.forEach((element) {
      _itemsPeriodicidad
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<int> _listaNumDias = new List<int>.generate(31, (i) => i + 1);
    List<DropdownMenuItem<String>> _itemsNumDias = [];
    _itemsNumDias.add(DropdownMenuItem(child: Text('Día'), value: 'Día'));
    _listaNumDias.forEach((element) {
      _itemsNumDias.add(DropdownMenuItem(
          child: Text(element.toString()), value: element.toString()));
    });

    List<String> _listaDiasSemana = [
      'Día',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    List<DropdownMenuItem<String>> _itemsDiasSemana = [];
    _listaDiasSemana.forEach((element) {
      _itemsDiasSemana
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _listaMeses = [
      'Mes',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    List<DropdownMenuItem<String>> _itemsMeses = [];
    _listaMeses.forEach((element) {
      _itemsMeses.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposTipoGasto = ['Tipo de gasto', 'Gasto', 'Ingreso'];
    List<DropdownMenuItem<String>> _itemsTipoGasto = [];
    _tiposTipoGasto.forEach((element) {
      _itemsTipoGasto
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuProvider(id: id, user: user, currentPage: 'SettingsPage'),
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
                          'Añadir recordatorio',
                          style: TextStyle(
                              fontSize: 23.0,
                              color: CustomColor.almostBlackColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ))),
            Column(
              children: [
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
                            labelText: 'Nombre del recordatorio',
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
                            labelText: 'Precio (en €)',
                          ),
                          //initialValue: precio.toString(),
                          onChanged: (valor) {
                            setState(() {
                              precio = double.parse(valor);
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: CustomColor.almostWhiteColor,
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        value: periodicidad,
                        items: _itemsPeriodicidad,
                        onChanged: (opt) {
                          setState(() {
                            periodicidad = opt;
                            if (periodicidad == 'Anual') {
                              isAnual = true;
                              isSemanal = false;
                              isDiario = false;
                              isPeriodicidad = false;
                            } else if (periodicidad == 'Semanal') {
                              isAnual = false;
                              isSemanal = true;
                              isDiario = false;
                              isPeriodicidad = false;
                            } else if (periodicidad == 'Diaria') {
                              isAnual = false;
                              isSemanal = false;
                              isDiario = true;
                              isPeriodicidad = false;
                            } else if (periodicidad == 'Periodicidad') {
                              isAnual = false;
                              isSemanal = false;
                              isDiario = false;
                              isPeriodicidad = true;
                            } else {
                              isAnual = false;
                              isSemanal = false;
                              isDiario = false;
                              isPeriodicidad = false;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // TextFormField(
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.number,
                      //     cursorColor: CustomColor.mainColor,
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.circular(15.0)),
                      //       labelText: 'Día para recordar',
                      //     ),
                      //     initialValue:
                      //         m == '00' ? d : d + ' de ' + m,
                      //     onChanged: (valor) {
                      //       setState(() {
                      //         fechaRecordar = valor;
                      //       });
                      //     }),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            width: _width * 0.38,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabled:
                                    (isDiario | isPeriodicidad) ? false : true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0)),
                                ),
                                filled: true,
                                fillColor: CustomColor.almostWhiteColor,
                                labelText: 'Día',
                              ),
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                              value: isPeriodicidad
                                  ? null
                                  : !isDiario
                                      ? d
                                      : null,
                              items: isPeriodicidad
                                  ? []
                                  : isSemanal
                                      ? _itemsDiasSemana
                                      : isDiario
                                          ? []
                                          : _itemsNumDias,
                              onChanged: (opt) {
                                setState(() {
                                  d = opt;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Expanded(
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabled: isAnual,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0)),
                                  ),
                                  filled: true,
                                  fillColor: CustomColor.almostWhiteColor,
                                  labelText: 'Mes',
                                ),
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16),
                                value: isAnual ? m : null,
                                items: isAnual ? _itemsMeses : [],
                                onChanged: (valor) {
                                  setState(() {
                                    m = valor;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: CustomColor.almostWhiteColor,
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        //value: tipoGasto ? 'Gasto' : !tipoGasto ? 'Ingreso' : 'e',
                        value: tipoGasto == null
                            ? 'Tipo de gasto'
                            : tipoGasto
                                ? 'Gasto'
                                : 'Ingreso',
                        items: _itemsTipoGasto,
                        onChanged: (opt) {
                          setState(() {
                            //strTipoGasto = opt;
                            if (opt == 'Gasto') {
                              tipoGasto = true;
                            } else if (opt == 'Ingreso') {
                              tipoGasto = false;
                            } else {
                              tipoGasto = null;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             ChangeMyDataPage())
                          // );
                          // updateUser(
                          //     _nombre,
                          //     _apellidos,
                          //     _laboral,
                          //     _birth,
                          //     _sexo,
                          //     _numTelefono);
                          // updateRecordatorio(recordatorioId, nombre,
                          //     precio, periodicidad, d, m, tipoGasto);
                          saveButton(
                              nombreSave: nombre,
                              precioSave: precio,
                              periodicidadSave: periodicidad,
                              diaSave: d,
                              mesSave: m,
                              tipoGastoSave: tipoGasto);
                        },
                        child: Text('Añadir'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                CustomColor.mainColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                CustomColor.softColor),
                            //side: MaterialStateProperty.all<BorderSide>(),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.fromLTRB(30, 15, 30, 15))),
                      ),
                      SizedBox(height: 10.0)
                    ]),
                  ),
                ),
                SizedBox(height: 30.0)
              ],
            )
          ])),
          IconButton(
            padding: EdgeInsets.only(top: 60),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ]));
  }

  saveButton(
      {String nombreSave,
      dynamic precioSave,
      String periodicidadSave,
      dynamic diaSave,
      String mesSave,
      bool tipoGastoSave}) async {
    if (diaSave.length == 1) {
      diaSave = '0' + diaSave;
    }

    String fechaRecordarSave;
    if (periodicidadSave == 'Anual') {
      fechaRecordarSave = diaSave + '/' + m;
    } else if (periodicidadSave == 'Semanal') {
      fechaRecordarSave = diaSave;
    } else {
      fechaRecordarSave = diaSave + '/00';
    }

    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('reminds');

    DocumentReference doc = await db.add({
      'FechaRecordar': fechaRecordarSave,
      'Nombre': nombreSave,
      'Periodicidad': periodicidadSave,
      'Precio': precioSave,
      'TipoGasto': tipoGastoSave
    });

    String conf = 'false';

    conf = await getRecordatorio(remindId: doc.id, id: id);

    String titulo = '';
    String contenido = '';
    if (conf == 'true') {
      titulo = 'Se ha guardado el recordatorio';
      contenido = 'El registro del recordatorio se ha guardado correctamente.';
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
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              child: Text('Aceptar')),
        ],
      ),
    );
  }
}
