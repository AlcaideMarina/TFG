import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundSettings.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';

import 'package:image_picker/image_picker.dart';

class MyDataSettingsPage extends StatefulWidget {
  MyDataSettingsPage({Key key, this.id, this.user, this.familyId})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String familyId;

  @override
  _MyDataSettingsPageState createState() =>
      _MyDataSettingsPageState(this.id, this.user, this.familyId);
}

class _MyDataSettingsPageState extends State<MyDataSettingsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();

  final String id;
  final DocumentSnapshot user;
  final String familyId;

  _MyDataSettingsPageState(this.id, this.user, this.familyId);

  TextEditingController _inputFieldDateController = new TextEditingController();

  String _birth;
  String _sexo = 'Sexo';
  String _laboral = 'Situación laboral';

  dynamic _nombre;
  dynamic _apellidos;

  dynamic _fhNacimiento;
  dynamic _numTelefono;
  File _imagen;
  String _urlImagen;
  String _email;

  bool _fhCambiada = false;
  bool _primeraVez = true;
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tiposSexo = ['Hombre', 'Mujer', 'Prefiero no decirlo'];
    List<DropdownMenuItem<String>> _itemsSexo = [];
    _tiposSexo.forEach((element) {
      _itemsSexo.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposSLaboral = [
      'Activo/a',
      'Parado/a',
      'Jubilado/a',
      'Trabajo doméstico no remunerado',
      'Estudiante'
    ];
    List<DropdownMenuItem<String>> _itemsSLaboral = [];
    _tiposSLaboral.forEach((element) {
      _itemsSLaboral
          .add(DropdownMenuItem(child: Text(element), value: element));
    });

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
                        .collection('users')
                        .doc(id)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      final allFields = snapshot.data;
                      if (snapshot.hasData) {
                        if (_primeraVez) {
                          _nombre = allFields['Nombre'];
                          _apellidos = allFields['Apellidos'];
                          _laboral = allFields['EstLaboral'];
                          _fhNacimiento = allFields['FchNacimiento'];
                          _numTelefono = allFields['NTelefono'].toString();
                          _sexo = allFields['Sexo'];
                          _urlImagen = allFields['Imagen'];
                          _email = FirebaseAuth.instance.currentUser.email;

                          _inputFieldDateController.text = _fhNacimiento;
                          _birth = _fhNacimiento;

                          _primeraVez = false;
                        }

                        return Column(
                          children: [
                            SafeArea(
                                bottom: false,
                                child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    //height: _height * 0.1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: _height * 0.06),
                                        Center(
                                          child: Container(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (_enabled) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                              title: Text(
                                                                  'Selecciona una foto de perfil'),
                                                              actions: <Widget>[
                                                                IconButton(
                                                                    icon: Icon(Icons
                                                                        .photo_camera), //Cámara
                                                                    onPressed:
                                                                        () async {}),
                                                                IconButton(
                                                                    icon: Icon(Icons
                                                                        .photo_library), //Galería
                                                                    onPressed:
                                                                        () async {
                                                                      try {
                                                                        if (_imagen !=
                                                                            null) {
                                                                          _urlImagen =
                                                                              null;
                                                                        }

                                                                        final _picker =
                                                                            ImagePicker();
                                                                        final pickedFile =
                                                                            await _picker.getImage(source: ImageSource.gallery);

                                                                        if (pickedFile !=
                                                                            null) {
                                                                          _imagen =
                                                                              File(pickedFile.path);
                                                                          _urlImagen =
                                                                              pickedFile.path;

                                                                          setState(
                                                                              () {});
                                                                        }
                                                                      } catch (e) {
                                                                        print(e
                                                                            .toString());
                                                                      }
                                                                    }),
                                                              ]));
                                                }
                                              },
                                              child: CircleAvatar(
                                                child: null,
                                                backgroundImage: _urlImagen ==
                                                        null
                                                    ? AssetImage(
                                                        'assets/random_user.png')
                                                    : new NetworkImage(
                                                        user['Imagen']),
                                                radius: _width * 0.25,
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    CustomColor.shadowColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                            SizedBox(
                              height: _height * 0.06,
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.almostWhiteColor,
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
                                key: _formKey,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          enabled: _enabled,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: CustomColor.mainColor,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            labelText: 'Nombre',
                                          ),
                                          initialValue: _nombre,
                                          onChanged: (valor) {
                                            setState(() {
                                              _nombre = valor;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 15.0),
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
                                        SizedBox(height: 15.0),
                                        TextFormField(
                                          enabled: _enabled,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: CustomColor.mainColor,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            labelText: 'Correo',
                                          ),
                                          initialValue: _email,
                                          onChanged: (valor) {
                                            setState(() {
                                              _email = valor;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 15.0),
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabled: _enabled,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 20.5, 0, 15),
                                            border: OutlineInputBorder(
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  const Radius.circular(15.0)),
                                            ),
                                            filled: true,
                                            fillColor:
                                                CustomColor.almostWhiteColor,
                                          ),
                                          value: _laboral,
                                          items: _itemsSLaboral,
                                          onChanged: (opt) {
                                            setState(() {
                                              _laboral = opt;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 15.0),
                                        TextField(
                                          enabled: _enabled,
                                          cursorColor: CustomColor.mainColor,
                                          textInputAction: TextInputAction.next,
                                          enableInteractiveSelection: false,
                                          controller: _inputFieldDateController,
                                          decoration: InputDecoration(
                                            fillColor:
                                                CustomColor.almostWhiteColor,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            hintText: 'Fecha de nacimiento',
                                            labelText: 'Fecha de nacimiento',
                                          ),
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            _selectDate(context);
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _fhNacimiento = value;
                                              _inputFieldDateController.text =
                                                  value;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 15.0),
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            enabled: _enabled,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 20.5, 0, 15),
                                            border: OutlineInputBorder(
                                              borderRadius: const BorderRadius
                                                      .all(
                                                  const Radius.circular(15.0)),
                                            ),
                                            filled: true,
                                            fillColor:
                                                CustomColor.almostWhiteColor,
                                          ),
                                          value: _sexo,
                                          items: _itemsSexo,
                                          onChanged: (opt) {
                                            setState(() {
                                              _sexo = opt;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 15.0),
                                        TextFormField(
                                          enabled: _enabled,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: CustomColor.mainColor,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            hintText: 'Número de teléfono',
                                            labelText: 'Número de teléfono',
                                          ),
                                          initialValue: _numTelefono.toString(),
                                          onChanged: (valor) {
                                            setState(() {
                                              _numTelefono = valor;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 40.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             ChangeMyDataPage())
                                            // );
                                            updateUser(
                                                _nombre,
                                                _apellidos,
                                                _laboral,
                                                _inputFieldDateController.text,
                                                _sexo,
                                                _numTelefono);
                                          },
                                          child: Text('Cambiar datos'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      CustomColor.mainColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              overlayColor:
                                                  MaterialStateProperty.all<Color>(
                                                      CustomColor.softColor),
                                              //side: MaterialStateProperty.all<BorderSide>(),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                      EdgeInsets.fromLTRB(
                                                          30, 15, 30, 15))),
                                        ),
                                        SizedBox(height: 20.0)
                                      ],
                                    ))),
                            SizedBox(height: _height * 0.06)
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))),
        /**/
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now(),
        locale: Locale('es', 'ES'),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light()
                    .copyWith(primary: CustomColor.gradientColor)),
            child: child,
          );
        });
    if (picked != null) {
      setState(() {
        _birth = picked.toString();
        String y = _birth.substring(0, 4);
        String m = _birth.substring(5, 7);
        String d = _birth.substring(8, 10);

        _inputFieldDateController.text = d + '/' + m + '/' + y;
        //_inputFieldDateControler.text = _birth;
        _fhCambiada = true;
      });
    }
  }

  updateUser(dynamic _nombre, dynamic _apellidos, dynamic _laboral,
      dynamic _fhNac, dynamic _sexo, dynamic _numTel) async {
    String conf = await updateUs(
        id: id,
        nombre: _nombre,
        apellidos: _apellidos,
        laboral: _laboral,
        fhNac: _fhNac,
        sexo: _sexo,
        numTel: _numTel);

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
}

class SingleTableCard extends StatelessWidget {
  final IconData icono;
  final Color color;
  final String label;
  final String id;
  final DocumentSnapshot user;

  const SingleTableCard(
      {Key key, this.icono, this.color, this.label, this.id, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: GestureDetector(
              child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: CustomColor.darkColor.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: this.color,
                          child: Icon(this.icono,
                              size: 35.0, color: CustomColor.almostWhiteColor),
                          radius: 30.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          this.label,
                          style: TextStyle(
                              color: CustomColor.softColor, fontSize: 15.0),
                        )
                      ])),
              onTap: () {
                if (label == 'Mis datos') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyDataSettingsPage(
                              user: user,
                              id: id,
                            )),
                  );
                }
                if (label == 'Mi familia') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyDataSettingsPage(
                              user: user,
                              id: id,
                            )),
                  );
                }
                if (label == 'Constantes') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyDataSettingsPage(
                              user: user,
                              id: id,
                            )),
                  );
                }
              },
            )),
      ),
    );
  }
}
