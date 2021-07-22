import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/card/chart/lineChart_card.dart';
import 'package:homeconomy/src/card/chart/pieChart_card.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class MyCategoriesPage extends StatefulWidget {
  MyCategoriesPage({Key key, @required this.id, @required this.user})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;

  @override
  _MyCategoriesPageState createState() =>
      _MyCategoriesPageState(this.id, this.user);
}

class _MyCategoriesPageState extends State<MyCategoriesPage> {
  final String id;
  final DocumentSnapshot user;
  _MyCategoriesPageState(this.id, this.user);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuProvider(id: id, currentPage: 'MyCategories', user: user),
      body: Stack(children: [
        CustomBackgroundAll(),
        SingleChildScrollView(
            child: Column(children: [
          // SafeArea(
          //     top: false,
          //     child: Container(
          //       height: _height * 0.1,
          //     )),
          // Container(
          //   child: Text('Mis categorías',
          //       style: TextStyle(
          //           fontSize: 20.0,
          //           color: CustomColor.darkColor,
          //           fontWeight: FontWeight.bold)),
          //   padding: EdgeInsets.only(),
          // ),
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
                        'Mis categorías',
                        style: TextStyle(
                            fontSize: 23.0,
                            color: CustomColor.almostBlackColor),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ))),
          Align(
            alignment: Alignment.center,
            child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                //margin: EdgeInsets.symmetric(vertical: 15.0,),
                child: Container(
                  width: _width * 0.9,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: //Column(
                      // children: [
                      //SizedBox(height: 7.0),
                      SafeArea(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(id)
                                .collection('categories')
                                .orderBy('Name')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              final allCategories = snapshot.data;
                              if (snapshot.hasData) {
                                return SizedBox(
                                    width: _width * 0.9,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: allCategories.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DocumentSnapshot catActual =
                                            allCategories.docs[index];
                                        String nombre = catActual['Name'];
                                        Color color = Color(catActual['Color']);
                                        String tipo = catActual['Type'];

                                        return Container(
                                          // padding: EdgeInsets.symmetric(
                                          //   horizontal: 20.0,
                                          //   vertical: 10.0
                                          // ),
                                          padding: EdgeInsets.zero,
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(
                                              padding: EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Container(
                                                  color: color,
                                                ),
                                              ),
                                            ),
                                            title: Text(nombre),
                                            subtitle: Text(tipo),
                                            trailing: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon:
                                                        Icon(Icons.edit_rounded),
                                                    color: CustomColor.darkColor,
                                                    tooltip: 'Editar categoría',
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdateCategoryPage(
                                                                      id: id,
                                                                      user: user,
                                                                      categoryId:
                                                                          catActual
                                                                              .id)));
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .delete_outline_rounded),
                                                    color: CustomColor.darkColor,
                                                    tooltip: 'Eliminar categoría',
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  new AlertDialog(
                                                                    title: Text(
                                                                        'Atención'),
                                                                    content: Text(
                                                                        'Va a eliminar la categoría ' +
                                                                            nombre
                                                                                .toUpperCase() +
                                                                            '.\nEsta acción será permanente.\n¿Está seguro de esto?'),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            String conf = await deleteDocument(
                                                                                collection: 'categories',
                                                                                id: id,
                                                                                documentId: catActual.id);

                                                                            Navigator.of(context)
                                                                                .pop();
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (_) => new AlertDialog(title: conf == 'true' ? new Text('Categoría eliminada') : new Text('Error'), content: conf == 'true' ? new Text('La categoría seleccionada se ha eliminado correctamente.') : new Text('Se ha producido un error eliminando la categoría seleccionada. Por favor, inténtelo de nuevo.'), actions: <Widget>[
                                                                                      TextButton(
                                                                                        child: Text('Aceptar', style: TextStyle(color: CustomColor.mainColor)),
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop();
                                                                                        },
                                                                                      ),
                                                                                    ]));
                                                                          },
                                                                          child: Text(
                                                                              'Eliminar'),
                                                                          style: TextButton
                                                                              .styleFrom(
                                                                            primary:
                                                                                CustomColor.mainColor,
                                                                          )),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context)
                                                                                .pop();
                                                                          },
                                                                          child: Text(
                                                                              'Cancelar'),
                                                                          style: TextButton
                                                                              .styleFrom(
                                                                            primary:
                                                                                CustomColor.mainColor,
                                                                          ))
                                                                    ],
                                                                  ));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            onLongPress: () {
                                              //gráfico temporal
                                              dynamic categorias;
                                              SafeArea(
                                                child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(id)
                                                      .collection('transactions')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    final actual = snapshot.data;
                                                    if(snapshot.hasData) {
                                                      categorias = actual['categorias'];
                                                      print(categorias.toString());
                                                      return Text(categorias.toString());
                                                    }
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                ),
                                              );



                                              // print('h');
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => new AlertDialog(
                                                        title: new Text(nombre +
                                                            ' en el tiempo'),
                                                        content:
                                                            new Text(categorias.toString())
                                                      ));
                                            },
                                          ),
                                        );
                                      },
                                    ));
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }),
                      ),
                  //                     ],
                  //)
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Align(
          //     alignment: Alignment.center,
          //     child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 15.0),
          //         //margin: EdgeInsets.symmetric(vertical: 15.0,),
          //         child: PieChartCard()))
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
      floatingActionButton: FloatingActionButton(
        splashColor: CustomColor.mainColor,
        backgroundColor: CustomColor.darkColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateCategoryPage(id: id, user: user)));
        },
        tooltip: 'Añadir nueva categoría',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateCategoryPage extends StatefulWidget {
  CreateCategoryPage({
    Key key,
    @required this.id,
    @required this.user,
  }) : super(key: key);

  final String id;
  final DocumentSnapshot user;

  @override
  _CreateCategoryPageState createState() =>
      _CreateCategoryPageState(this.id, this.user);
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final String id;
  final DocumentSnapshot user;

  _CreateCategoryPageState(this.id, this.user);

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

  String _tipo = 'Tipo';
  String _color = 'Color';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tiposCategorias = ['Tipo', 'Gasto', 'Ingreso'];
    List<DropdownMenuItem<String>> _itemsTiposCategorias = [];
    _tiposCategorias.forEach((element) {
      _itemsTiposCategorias
          .add(DropdownMenuItem(child: Text(element), value: element));
    });
    // Color currentColor = Colors.amber;
    // void changeColor(Color color) => setState(() => currentColor = color);

    List<String> _listaColores = [
      'Color',
      'Amarillo',
      'Naranja',
      'Rojo',
      'Rosa',
      'Lila',
      'Morado',
      'Azul claro',
      'Azul oscuro',
      'Verde claro',
      'Verde oscuro',
      'Marrón',
      'Gris',
      'Negro'
    ];
    List<DropdownMenuItem<String>> _itemsColores = [];
    _listaColores.forEach((element) {
      _itemsColores.add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuProvider(id: id, user: user, currentPage: 'SettingsPage'),
        body: Stack(children: [
          CustomBackgroundAll(),
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
                          'Añadir categoría',
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
                            labelText: 'Nombre de la categoría',
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
                        value: _tipo,
                        items: _itemsTiposCategorias,
                        onChanged: (opt) {
                          setState(() {
                            _tipo = opt;
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
                      //ColorPicker(pickerColor: Colors.red, onColorChanged: changeColor,),
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
                        value: _color,
                        items: _itemsColores,
                        onChanged: (opt) {
                          setState(() {
                            _color = opt;
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
                              tipoSave: _tipo,
                              colorSave: _color);
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

  saveButton({String nombreSave, String tipoSave, String colorSave}) async {
    bool vacio = false;
    if (nombreSave == null) {
      vacio = true;
    }
    if (tipoSave == null || tipoSave == 'Tipo') {
      vacio = true;
    }
    if (colorSave == null || colorSave == 'Color') {
      vacio = true;
    }

    if (vacio == false) {
      int codigoColor;
      if (colorSave == 'Amarillo') {
        codigoColor = 4294962020;
      } else if (colorSave == 'Naranja') {
        codigoColor = 4294948964;
      } else if (colorSave == 'Rojo') {
        codigoColor = 4294912554;
      } else if (colorSave == 'Rosa') {
        codigoColor = 4294926532;
      } else if (colorSave == 'Lila') {
        codigoColor = 4293888767;
      } else if (colorSave == 'Morado') {
        codigoColor = 4285339051;
      } else if (colorSave == 'Azul claro') {
        codigoColor = 4286899711;
      } else if (colorSave == 'Azul oscuro') {
        codigoColor = 4279386772;
      } else if (colorSave == 'Verde claro') {
        codigoColor = 4286054301;
      } else if (colorSave == 'Verde oscuro') {
        codigoColor = 4279921447;
      } else if (colorSave == 'Marrón') {
        codigoColor = 4285218586;
      } else if (colorSave == 'Gris') {
        codigoColor = 42879274440;
      } else if (colorSave == 'Negro') {
        codigoColor = 4278190080;
      } else {
        codigoColor = -1;
      }

      final db = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('categories');

      DocumentReference doc = await db
          .add({'Name': nombreSave, 'Type': tipoSave, 'Color': codigoColor});

      String conf = 'false';

      conf = await checkIfExists(
          collection: 'categories', userId: id, documentId: doc.id);

      String titulo = '';
      String contenido = '';
      if (conf == 'true') {
        titulo = 'Se ha guardado la categoría';
        contenido =
            'El registro de la nueva categoría se ha guardado correctamente.';
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
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                  title: Text('Revise los datos'),
                  content: Text(
                      'Faltan campos por rellenar.\nPor favor, revise el formulario.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar'))
                  ]));
    }
  }
}

class UpdateCategoryPage extends StatefulWidget {
  UpdateCategoryPage({
    Key key,
    @required this.id,
    @required this.user,
    @required this.categoryId,
  }) : super(key: key);

  final String id;
  final DocumentSnapshot user;
  final String categoryId;

  @override
  _UpdateCategoryPageState createState() =>
      _UpdateCategoryPageState(this.id, this.user, this.categoryId);
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  final String id;
  final DocumentSnapshot user;
  final String categoryId;

  _UpdateCategoryPageState(this.id, this.user, this.categoryId);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String nombre;
  String tipo;
  int codigoColor;
  String color;
  bool primeraVez = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tiposCategorias = ['Gasto', 'Ingreso'];
    List<DropdownMenuItem<String>> _itemsTiposCategorias = [];
    _tiposCategorias.forEach((element) {
      _itemsTiposCategorias
          .add(DropdownMenuItem(child: Text(element), value: element));
    });
    // Color currentColor = Colors.amber;
    // void changeColor(Color color) => setState(() => currentColor = color);

    List<String> _listaColores = [
      'Amarillo',
      'Naranja',
      'Rojo',
      'Rosa',
      'Lila',
      'Morado',
      'Azul claro',
      'Azul oscuro',
      'Verde claro',
      'Verde oscuro',
      'Marrón',
      'Gris',
      'Negro'
    ];
    List<DropdownMenuItem<String>> _itemsColores = [];
    _listaColores.forEach((element) {
      _itemsColores.add(DropdownMenuItem(child: Text(element), value: element));
    });

    return Scaffold(
        key: _scaffoldKey,
        drawer: MenuProvider(id: id, user: user, currentPage: 'SettingsPage'),
        body: Stack(children: [
          CustomBackgroundAll(),
          SingleChildScrollView(
            child: SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
                    .collection('categories')
                    .doc(categoryId)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allFields = snapshot.data;
                  if (snapshot.hasData && !snapshot.hasError) {
                    if (primeraVez) {
                      nombre = allFields['Name'];
                      tipo = allFields['Type'];
                      codigoColor = allFields['Color'];

                      if (codigoColor == 4294962020) {
                        color = 'Amarillo';
                      }
                      if (codigoColor == 4294948964) {
                        color = 'Naranza';
                      }
                      if (codigoColor == 4294912554) {
                        color = 'Rojo';
                      }
                      if (codigoColor == 4294926532) {
                        color = 'Rosa';
                      }
                      if (codigoColor == 4293888767) {
                        color = 'Lila';
                      }
                      if (codigoColor == 4285339051) {
                        color = 'Morado';
                      }
                      if (codigoColor == 4286899711) {
                        color = 'Azul claro';
                      }
                      if (codigoColor == 4279386772) {
                        color = 'Azul oscuro';
                      }
                      if (codigoColor == 4286054301) {
                        color = 'Verde claro';
                      }
                      if (codigoColor == 4279921447) {
                        color = 'Verde oscuro';
                      }
                      if (codigoColor == 4285218586) {
                        color = 'Marrón';
                      }
                      if (codigoColor == 42879274440) {
                        color = 'Gris';
                      }
                      if (codigoColor == 4278190080) {
                        color = 'Negro';
                      } else {
                        color = 'Negro';
                      }

                      primeraVez = false;
                    }

                    return Column(children: [
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
                                    'Editar categoría',
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
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      labelText: 'Nombre de la categoría',
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
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 16),
                                  value: tipo,
                                  items: _itemsTiposCategorias,
                                  onChanged: (opt) {
                                    setState(() {
                                      tipo = opt;
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
                                //ColorPicker(pickerColor: Colors.red, onColorChanged: changeColor,),
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
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 16),
                                  value: color,
                                  items: _itemsColores,
                                  onChanged: (opt) {
                                    setState(() {
                                      color = opt;
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
                                    updateButton(
                                        categoryId: categoryId,
                                        nombreSave: nombre,
                                        tipoSave: tipo,
                                        colorSave: color);
                                  },
                                  child: Text('Guardar datos'),
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
                      )
                    ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
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

  updateButton(
      {String categoryId,
      String nombreSave,
      String tipoSave,
      String colorSave}) async {
    bool vacio = false;
    if (nombreSave == null) {
      vacio = true;
    }
    if (tipoSave == null || tipoSave == 'Tipo') {
      vacio = true;
    }
    if (colorSave == null || colorSave == 'Color') {
      vacio = true;
    }

    if (vacio == false) {
      int codigoColor;
      if (colorSave == 'Amarillo') {
        codigoColor = 4294962020;
      } else if (colorSave == 'Naranja') {
        codigoColor = 4294948964;
      } else if (colorSave == 'Rojo') {
        codigoColor = 4294912554;
      } else if (colorSave == 'Rosa') {
        codigoColor = 4294926532;
      } else if (colorSave == 'Lila') {
        codigoColor = 4293888767;
      } else if (colorSave == 'Morado') {
        codigoColor = 4285339051;
      } else if (colorSave == 'Azul claro') {
        codigoColor = 4286899711;
      } else if (colorSave == 'Azul oscuro') {
        codigoColor = 4279386772;
      } else if (colorSave == 'Verde claro') {
        codigoColor = 4286054301;
      } else if (colorSave == 'Verde oscuro') {
        codigoColor = 4279921447;
      } else if (colorSave == 'Marrón') {
        codigoColor = 4285218586;
      } else if (colorSave == 'Gris') {
        codigoColor = 42879274440;
      } else if (colorSave == 'Negro') {
        codigoColor = 4278190080;
      } else {
        codigoColor = -1;
      }

      String conf = await updateCat(id: id, categoryId: categoryId, nombre: nombre, tipo: tipo, color: codigoColor);

      String titulo = '';
      String contenido = '';
      if (conf == 'true') {
        titulo = 'Se ha actualizo la categoría';
        contenido =
            'Se ha actualizado  categoría se ha guardado correctamente.';
      } else {
        titulo = 'Ha ocurrido un error';
        contenido =
            'Se ha producido un error al actualizar los datos.\nMensaje de error: ' +
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
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                  title: Text('Revise los datos'),
                  content: Text(
                      'Faltan campos por rellenar.\nPor favor, revise el formulario.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar'))
                  ]));
    }
  }
}
