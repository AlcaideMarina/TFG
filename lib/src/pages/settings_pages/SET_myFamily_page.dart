import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundSettings.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/card/single/familyMembersSettings_card.dart';
import 'package:homeconomy/src/card/single/familyMembers_card.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/pages/newFamily_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

class MyFamilySettingsPage extends StatefulWidget {
  const MyFamilySettingsPage(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.familyId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _MyFamilySettingsPage createState() =>
      _MyFamilySettingsPage(this.id, this.user, this.familyId);
}

class _MyFamilySettingsPage extends State<MyFamilySettingsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();
  TextEditingController _inputFieldDateController = new TextEditingController();

  final String id;
  final DocumentSnapshot user;
  final String familyId;

  _MyFamilySettingsPage(this.id, this.user, this.familyId);

  String _apellidos;
  String _familyName;
  String _imageUrl;
  List<dynamic> _miembros;

  bool _primeraVez = true;
  bool _enabled = false;

  String nombre;
  String apellidos;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    if (familyId == "") {
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
                                    NewFamilyPage(id: id, user: user, crear: false)),
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
                                    NewFamilyPage(id: id, user: user, crear: true)),
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
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        drawer: MenuProvider(
          id: id,
          user: user,
          currentPage: 'SettingsPage',
        ),
        floatingActionButton: IconButton(
          icon: Icon(Icons.edit_rounded),
          color: Colors.white,
          padding: EdgeInsets.only(top: _height * 0.045, left: _width * 0.02),
          onPressed: () {
            setState(() => _enabled = true);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Stack(children: [
          CustomBackgroundSettings(),
          SingleChildScrollView(
            child: SafeArea(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('families')
                      .doc(familyId)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final allFamFields = snapshot.data;
                    if (snapshot.hasData) {
                      final idAdmin = allFamFields['Admin'];
                      if (idAdmin == id) {
                        if (_primeraVez) {
                          _familyName = allFamFields['familyName'];
                          _imageUrl = allFamFields['Image'];
                          _apellidos = allFamFields['surnames'];
                          _miembros = allFamFields['members'];
                          _primeraVez = false;
                        }

                        return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Column(
                                  children: [
                                    SafeArea(
                                        bottom: false,
                                        child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: _height * 0.06),
                                                Center(
                                                    child: Container(
                                                        child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                'Selecciona una foto de perfil',
                                                              ),
                                                              actions: <Widget>[
                                                                IconButton(
                                                                  icon: Icon(Icons
                                                                      .photo_camera),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                                IconButton(
                                                                  icon: Icon(Icons
                                                                      .photo_library),
                                                                  onPressed:
                                                                      () {},
                                                                )
                                                              ],
                                                            ));
                                                  },
                                                  child: CircleAvatar(
                                                    child: null,
                                                    backgroundImage: _imageUrl ==
                                                            ''
                                                        ? AssetImage(
                                                            'assets/random_user.png')
                                                        : new NetworkImage(
                                                            _imageUrl),
                                                    radius: _width * 0.25,
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        CustomColor.shadowColor,
                                                  ),
                                                )))
                                              ],
                                            ))),
                                    SizedBox(height: _height * 0.06),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CustomColor.almostWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors
                                                    .black26, //CustomColor.shadowColor,
                                                blurRadius: 10.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(0.0, 5.0)),
                                          ],
                                        ),
                                        key: _formKey,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Column(children: [
                                              TextFormField(
                                                enabled: _enabled,
                                                textInputAction: TextInputAction.next,
                                                cursorColor: CustomColor.mainColor,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  labelText: 'Apellidos',
                                                ),
                                                initialValue: _apellidos,
                                                onChanged: (valor) {
                                                  setState(() {
                                                    _apellidos = valor;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              TextFormField(
                                                enabled: _enabled,
                                                textInputAction:
                                                    TextInputAction.next,
                                                cursorColor:
                                                    CustomColor.mainColor,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  labelText:
                                                      'Nombre de familia',
                                                ),
                                                initialValue: _familyName,
                                                onChanged: (valor) {
                                                  setState(() {
                                                    _familyName = valor;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 25.0),
                                              Text('Miembros:'),
                                              ListView.builder(
                                                  padding: EdgeInsets.all(10.0),
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  //itemExtent: 90,
                                                  itemCount: _miembros.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SafeArea(
                                                        child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(_miembros[
                                                                    index])
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        dynamic>
                                                                    snapshot) {
                                                              final allFields =
                                                                  snapshot.data;
                                                              if (snapshot
                                                                  .hasData) {
                                                                nombre =
                                                                    allFields[
                                                                        'Nombre'];
                                                                apellidos =
                                                                    allFields[
                                                                        'Apellidos'];

                                                                return Container(
                                                                  height: 80.0,
                                                                  child: // Row(
                                                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                                                      //   children: <Widget>[
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                11.0),
                                                                    child:
                                                                        GestureDetector(
                                                                      child: Card(
                                                                          elevation: 5.0,
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                            Container(
                                                                              height: 60,
                                                                              //width: _width * 0.4,
                                                                              padding: EdgeInsets.fromLTRB(20.0, 3.5, 30.0, 0),
                                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                SizedBox(height: 10.0),
                                                                                Text(nombre),
                                                                                Text(apellidos),
                                                                              ]),
                                                                              alignment: Alignment.centerLeft,
                                                                            ),
                                                                            Expanded(
                                                                              child: SizedBox(),
                                                                            ),
                                                                            // IconButton(
                                                                            //   //height: 60,
                                                                            //   //width: _width * 0.55,
                                                                            //   padding: EdgeInsets.fromLTRB(20.0, .5, 15.0, 0),
                                                                            //   alignment: Alignment.centerRight,
                                                                            //   icon: Icon(Icons.edit_rounded),

                                                                            //   onPressed: () {},
                                                                            // ),
                                                                            IconButton(
                                                                              //height: 60,
                                                                              //width: _width * 0.55,
                                                                              padding: EdgeInsets.fromLTRB(0.0, 10.5, 15.0, 0),
                                                                              alignment: Alignment.centerRight,
                                                                              icon: Icon(Icons.delete_outline),
                                                                              onPressed: () {
                                                                                deleteUser(familyId, _miembros[index], _miembros);
                                                                              },
                                                                            )
                                                                          ])),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              }
                                                            }));
                                                  }),
                                              SizedBox(height: 20.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  updateFamily(
                                                      nombreSave: _familyName,
                                                      apellidosSave:
                                                          _apellidos);
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
                                                },
                                                child: Text('Cambiar datos'),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            CustomColor
                                                                .mainColor),
                                                    foregroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    overlayColor: MaterialStateProperty.all<Color>(
                                                        CustomColor.softColor),
                                                    //side: MaterialStateProperty.all<BorderSide>(),
                                                    padding: MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                        EdgeInsets.fromLTRB(
                                                            30, 15, 30, 15))),
                                              ),
                                              SizedBox(height: 10.0),
                                            ]))),
                                    SizedBox(
                                      height: 40.0,
                                    )
                                  ],
                                )),
                          ],
                        );
                      } else {
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
                              Container(
                                padding: EdgeInsets.only(
                                    top: _height * 0.05, left: _width * 0.55),
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
                                    height: 140,
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
                                          color: Colors
                                              .black26, //CustomColor.shadowColor,
                                          blurRadius: 10.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0.0, 5.0)),
                                    ],
                                  ),
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(35, 10, 35, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vaya...',
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                            'No eres el administrador de la familia, así que no puedes modificar estos ajustes.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ])),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
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
  }

  updateFamily({
    dynamic nombreSave,
    dynamic apellidosSave,
  }) async {
    String conf = await updateFam(
      // esto arriba, en las variabels que pide el método: List<Strings> miembros
      familyId: familyId,
      apellidos: apellidosSave,
      nombre: nombreSave,
      // laboral: _laboral,
      // fhNac: _fhNac,
      // sexo: _sexo,
      // numTel: _numTel
    );

    if (conf == 'true') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Datos guardados'),
                content: new Text('Los datos se han guardado correctamente'),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK.',
                      style: TextStyle(color: CustomColor.mainColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                id: id, user: user, familyId: familyId),
                          ));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                id: id, user: user, familyId: familyId),
                          ));
                    },
                  )
                ],
              ));
    }
  }

  deleteUser(String familyId, String userId, List<dynamic> miembros) async {
    String conf = await deleteFamilyUser(familyId: familyId, userId: userId, miembros: miembros);
     if (conf == 'true') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Datos guardados'),
                content: new Text('Los datos se han guardado correctamente'),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK.',
                      style: TextStyle(color: CustomColor.mainColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                id: id, user: user, familyId: familyId),
                          ));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                id: id, user: user, familyId: familyId),
                          ));
                    },
                  )
                ],
              )); }
  }
}
