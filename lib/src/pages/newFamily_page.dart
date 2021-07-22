//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/backgrounds/customBackgroundAll.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';

class NewFamilyPage extends StatefulWidget {
  NewFamilyPage({Key key, @required this.id, @required this.user, @required this.crear})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final bool crear;

  @override
  _NewFamilyPageState createState() => _NewFamilyPageState(id: id, user: user, crear: crear);
}

class _NewFamilyPageState extends State<NewFamilyPage> {
  _NewFamilyPageState({this.id, this.user, this.crear});
  final String id;
  final DocumentSnapshot user;
  final bool crear;
  
    String _nombre;
    String _apellidos;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


if(crear){
return Container(
      child: Scaffold(
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
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(children: [
                      Text('Crea una familia'),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                          'Introduce el nombre y los apellidos de tu familia. Serán necesarios para mandar una petición y formar parte de tu familia.\nRecuerda que tú serás el administrador de la misma.'),
                     SizedBox(height: 25.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Nombre de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _nombre = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Apellidos de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _apellidos = valor;
                                });
                              },
                            ),
                            SizedBox(height: 40.0),
                            ElevatedButton(
                              onPressed: () async {
                                if(_nombre == null || _nombre == '' || _apellidos == null || _apellidos == '') { 
                                  showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                            title: new Text(
                                                'Revise el formulario'),
                                            content: new Text(
                                                'Hay datos sin rellenar.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('De acuerdo.'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                }

                                QuerySnapshot document = await searchFamily(
                                    name: _nombre,
                                    surnames: _apellidos);
                                if (document.docs.isEmpty) {
                                  createButton();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                            title: new Text(
                                                'Revise el formulario'),
                                            content: new Text(
                                                'Ya existe una familia con ese nombre y apellidos. Asegúrese de que no es la suya o cambie los datos.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('De acuerdo.'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                }
                              },
                              child: Text('Crear a una familia'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColor.mainColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal[10]),
                                  //side: MaterialStateProperty.all<BorderSide>(),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                            ),
                            SizedBox(height: 10.0)
                          ],
                        ),
                      )
                    ])),
              ),
            ])),
            IconButton(
              padding: EdgeInsets.only(top: 100),
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
} else{
  return Container(
      child: Scaffold(
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
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(children: [
                      Text('Únete a una familia'),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                          'Rellena el nombre y apellidos de la familia y manda la invitación. Esta llegará al administrador, quien decidirá si aceptarte o no.'),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          'Es importante que revises que los campos están bien. ¡Suerte!'),
                      SizedBox(height: 25.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Nombre de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _nombre = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Apellidos de la familia',
                                  icon: Icon(Icons.card_membership,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _apellidos = valor;
                                });
                              },
                            ),
                            SizedBox(height: 40.0),
                            ElevatedButton(
                              onPressed: () async {
                                QuerySnapshot document = await searchFamily(
                                    name: _nombre,
                                    surnames: _apellidos);
                                if (document.docs.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                            title: new Text(
                                                'Revisa el formulario'),
                                            content: new Text(
                                                'No existe ninguna familia que tenga esos datos. \nPor favor, revísa los campos, y asegúrate de que todo está correcto. Ten en cuenta todos los espacios, tildes, etc.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('De acuerdo.'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                } else {
                                  addRequest(family: document.docs[0]);
                                          showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                            title: new Text(
                                                '¡Ya está!'),
                                            content: new Text(
                                                'Ahora hay que esperar a que el administrador de la familia te acepte.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('De acuerdo.'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                }
                              },
                              child: Text('Únete a una familia'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColor.mainColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal[10]),
                                  //side: MaterialStateProperty.all<BorderSide>(),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(30, 15, 30, 15))),
                            ),
                            SizedBox(height: 10.0)
                          ],
                        ),
                      )
                    ])),
              ),
            ])),
            IconButton(
              padding: EdgeInsets.only(top: 100),
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
}
    
  }

  addRequest({
DocumentSnapshot family
  }) async {

    try{
      DocumentReference document2 = await FirebaseFirestore.instance
        .collection('families')
        .doc(family.id)
        .collection('requests')
        .add({
          'userId': id
        });
    }
    catch (e) {

    }

      
  }


  createButton({String nombreSave, String apellidosSave}) async {
    final db = FirebaseFirestore.instance
        .collection('families');

    DocumentReference doc = await db.add({
      'Admin': id,
      'Image': '',
      'familyName': nombreSave,
      'members': [id],
      'surnames': apellidosSave
    });

    String conf = 'false';

    conf = await strGetFamily(familyId: doc.id);

    String titulo = '';
    String contenido = '';
    if (conf == 'false') {
      titulo = 'Ha ocurrido un error.';
      contenido = 'No se ha podido crear la familia';
    } else if (conf == 'true') {
      titulo = '¡Ya está!';
      contenido =
          'Se ha creado la familia correctamente';
    } else {
      titulo = 'Ha ocurrido un error';
      contenido = 'No se ha podido crear la familia. ' + conf;
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
                        builder: (context) => HomePage(id: id, user: user)));
              },
              child: Text('Aceptar')),
        ],
      ),
    );
  }

}

