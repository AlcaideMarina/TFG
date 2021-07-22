import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/newUser_page.dart';

import 'newUser_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _inputFieldDateControler = new TextEditingController();
  String _name;
  String _surname;
  bool _isDNI = false;
  String _docId;
  String _birth;
  int _nTel;
  String _sex = 'Sexo';
  String _laboral = 'Situación laboral';
  String _email;
  String _password;
  String _password2;
  String _bankAccount;
  bool _isChecked = false;
  String _isDNIStr = 'Tipo';

  String id;

  // Widget _changedText = Text('');
  // changeText(String value) {
  //   setState(() {
  //     _changedText = Text(value,
  //         style: TextStyle(
  //           color: Colors.red,
  //         ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<String> _tiposDoc = ['Tipo', 'DNI', 'NIE'];
    List<DropdownMenuItem<String>> _itemsTipoDoc = [];
    _tiposDoc.forEach((element) {
      _itemsTipoDoc.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposSexo = [
      'Sexo',
      'Hombre',
      'Mujer',
      'Otro',
      'Prefiero no decirlo'
    ];
    List<DropdownMenuItem<String>> _itemsSexo = [];
    _tiposSexo.forEach((element) {
      _itemsSexo.add(DropdownMenuItem(child: Text(element), value: element));
    });

    List<String> _tiposSLaboral = [
      'Situación laboral',
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

    final customBackground = Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          CustomColor.mainColor,
          CustomColor.gradientColor
        ])));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            customBackground,
            Container(
              padding: EdgeInsets.only(top: _height * 0.10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/letrasBlanco.png',
                    width: _width * 0.8,
                  ),
                  SizedBox(width: double.infinity)
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(height: _height * 0.2),
                  ),
                  Container(
                    width: _width * 0.93,
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
                    child: //ListView(
                        //padding: EdgeInsets.symmetric(horizontal: _width - 390),
                        //children: [
                        //Text('prueba'),
                        Form(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(
                              'Registro',
                              style: TextStyle(
                                  fontSize: 19, color: CustomColor.mainColor),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  //changeText('Debe introducir una correo');
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Nombre',
                                  icon: Icon(Icons.person_outline_rounded,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _name = valor;
                                });
                              },
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  //changeText('Debe introducir una correo');
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Apellidos',
                                  icon: Icon(
                                    Icons.person_outline_rounded,
                                    color: CustomColor.mainColor,
                                  )),
                              onChanged: (valor) {
                                setState(() {
                                  _surname = valor;
                                });
                              },
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment,
                              children: [
                                Icon(Icons.camera_front_rounded, color: CustomColor.mainColor),
                                SizedBox(width: 15.0),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  width: _width / 4,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0)),
                                      ),
                                      filled: true,
                                      fillColor: CustomColor.almostWhiteColor,
                                    ),
                                    value: _isDNIStr,
                                    items: _itemsTipoDoc,
                                    onChanged: (opt) {
                                      setState(() {
                                        _isDNIStr = opt;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Expanded(
                                  child: SizedBox(
                                    child: TextFormField(
                                      cursorColor: CustomColor.mainColor,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        fillColor: CustomColor.almostWhiteColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        labelText: 'Doc. Identificativo',
                                      ),
                                      onChanged: (valor) {
                                        setState(() {
                                          _docId = valor;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  //changeText('Debe introducir una correo');
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Teléfono',
                                  icon: Icon(Icons.phone_outlined,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _nTel = int.parse(valor);
                                });
                              },
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              enableInteractiveSelection: false,
                              controller: _inputFieldDateControler,
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  hintText: 'Fecha de nacimiento',
                                  labelText: 'Fecha de nacimiento',
                                  icon: Icon(Icons.calendar_today,
                                      color: CustomColor.mainColor)),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                _selectDate(context);
                              },
                            ),
                            SizedBox(height: 15.0),
                            Row(children: [
                              Icon(Icons.self_improvement_outlined, color: CustomColor.mainColor),
                              SizedBox(width: 15.0,),
                              Expanded(
                              child:  DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0)),
                                  ),
                                  filled: true,
                                  fillColor: CustomColor.almostWhiteColor,
                                ),
                                value: _sex,
                                items: _itemsSexo,
                                onChanged: (opt) {
                                  setState(() {
                                    _sex = opt;
                                  });
                                },
                              ),
                              )
                             
                            ],),
                            
                            SizedBox(height: 15.0),
                            
                            Row(children: [
                              Icon(Icons.work_outline_rounded, color: CustomColor.mainColor),
                              SizedBox(width: 15.0,),
                              Expanded(child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 20.5, 0, 15),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0)),
                                ),
                                filled: true,
                                fillColor: CustomColor.almostWhiteColor,
                              ),
                              value: _laboral,
                              items: _itemsSLaboral,
                              onChanged: (opt) {
                                setState(() {
                                  _laboral = opt;
                                });
                              },
                            ),)
                              ]),
                            
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Correo electrónico',
                                  icon: Icon(
                                    Icons.mail_outline,
                                    color: CustomColor.mainColor,
                                  )),
                              onChanged: (valor) {
                                setState(() {
                                  _email = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Contraseña',
                                  icon: Icon(Icons.lock_outlined,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _password = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Repita la contraseña',
                                  icon: Icon(Icons.lock_outlined,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _password2 = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              cursorColor: CustomColor.mainColor,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: CustomColor.almostWhiteColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Cuenta bancaria',
                                  icon: Icon(Icons.credit_card,
                                      color: CustomColor.mainColor)),
                              onChanged: (valor) {
                                setState(() {
                                  _bankAccount = valor;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            CheckboxListTile(
                                title: Text(
                                  "Acepto términos y condiciones",
                                ),
                                value: _isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isChecked = newValue;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                          title: new Text(
                                              'Términos y condiciones'),
                                          content: new Text(
                                              'Al marcar esta casilla está consintiendo el tratamiento y almacenamiento de sus datos, así como el acceso a la lectura de sus cuentas. \nEstos datos, en ningún caso, serán mostrados a terceros.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('De acuerdo.'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              },
                              child: Text('Ver términos y condiciones'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColor.shadowColor),
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
                            SizedBox(
                              height: 15.0,
                            ),
                            // _changedText,
                            SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                signinButtom(
                                    _name,
                                    _surname,
                                    _isDNIStr,
                                    _docId,
                                    _email,
                                    _birth,
                                    _nTel,
                                    _sex,
                                    _laboral,
                                    _email,
                                    _password,
                                    _password2,
                                    _bankAccount,
                                    _isChecked,
                                    context);
                              },
                              child: Text('Registrarme'),
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
                              //textColor: Colors.white,
                              //color: Colors.teal,
                            ),
                            SizedBox(height: 25.0),
                          ],
                        ),
                      ),
                    ),
                    //],
                    //),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(top: _height * 0.08),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ));
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
        _inputFieldDateControler.text = _birth;
      });
    }
  }

  signinButtom(
      String name,
      String surname,
      String isDNIStr,
      String docId,
      String mail,
      String birth,
      int nTel,
      String sex,
      String laboral,
      String email,
      String password,
      String password2,
      String bankAccount,
      bool isChecked,
      context) async {
    // comprobaciones
    // Ver si algo está vacío
    // VER QUÉ ES NECESARIO Y QUÉ NO
    //String vacio = "";

    bool vacio = true;
    if (name == null) {
      //vacio = vacio + 'nombre, ';
      vacio = false;
    }
    if (surname == null) {
      //vacio = vacio + 'apellidos, ';
      vacio = false;
    }
    if (isDNIStr == 'Tipo') {
      //   vacio = vacio + 'nombre, ';
      vacio = false;
    }
    if (docId == null) {
      //vacio = vacio + 'documento identificativo, ';
      vacio = false;
    }
    if (birth == null) {
      //vacio = vacio + 'fecha de nacimiento, ';
      vacio = false;
    }
    if (nTel == null) {
      //   vacio = vacio + 'nombre, ';
      vacio = false;
    }
    if (sex == null) {
      //vacio = vacio + 'sexo, ';
      vacio = false;
    }
    if (password == null || password2 == null) {
      //vacio = vacio + 'contraseña, ';
      vacio = false;
    }
    if (bankAccount == null) {
      //vacio = vacio + 'número de cuenta, ';
      vacio = false;
    }

    if (laboral == null) {
      //vacio = vacio + 'estado laboral, ';
      vacio = false;
    }
    String frase = '';
    if (!vacio) {
      frase = frase +
          'Debe rellenar todos los campos.\n'; // Faltaría indicar los campos
    }

    if (EmailValidator.validate(email) == false) {
      frase = frase + 'El correo no tiene un formato correcto.\n';
    }

    if (password != password2) {
      frase = frase + 'Las contraseñas introducidas no coinciden.\n';
    }

    if (!isChecked) {
      frase = frase + 'Es necesario que acepte términos y condiciones.\n';
    }
    if (frase != '') {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Revise el formulario'),
                content: new Text(frase),
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

    // Añadir usuario
    if (frase == '') {
      String conf = await register(email: mail, password: password);

      if (conf == 'true') {
        String uid = FirebaseAuth.instance.currentUser.uid;
        bool isDNI;
        if (isDNIStr == 'DNI') {
          isDNI = true;
        } else {
          isDNI = false;
        }
        String y = birth.substring(1, 4);
        String m = birth.substring(6, 7);
        String d = birth.substring(9, 10);

        final databaseReference = FirebaseFirestore.instance;

        //await databaseReference.collection('bankAccount').add({});
        //String bankAccountId;

        await databaseReference.collection("users").add({
          'Nombre': name,
          'Apellidos': surname,
          //'Contraseña': password,
          'DNI': docId,
          //'Correo': mail,
          'EstLaboral': laboral,
          'FchNacimiento': d + '/' + m + '/' + y,
          'Imagen': "",
          'NTelefono': nTel,
          'Sexo': sex,
          'isDNI': isDNI,
          //'bankAccount': bankAccount,
          'Money': 1234.34,
          'FamilyID': '',
          'uid': uid,
        });

        String id = await getIdWithUid(uid: uid);
        if (id != null) {
          if (!id.contains('Error')) {
            Random rnd = new Random(DateTime.now().millisecondsSinceEpoch);
            num start = 748.23;
            num end = 3876.23;
            double dinero = double.parse(double.parse((rnd.nextDouble() * (end - start) + start).toString()).toStringAsFixed(2));
            await databaseReference
                .collection('users')
                .doc(id)
                .collection('bankAccounts')
                .add({
              'AccountNumber': bankAccount,
              'Money': dinero,
              'Name': 'Cuenta bancaria',
              'userId': id
            });

            await databaseReference
                .collection('users')
                .doc(id)
                .collection('categories')
                .add({
              'Color': 4294950233,
              'Name': 'Gastos genéricos',
              'Type': 'Gasto'
            });

            await databaseReference
                .collection('users')
                .doc(id)
                .collection('categories')
                .add({
              'Color': 4294343048,
              'Name': 'Ingresos genéricos',
              'Type': 'Ingresos'
            });

            FirebaseAuth.instance.currentUser.sendEmailVerification();
            String confLogIn;
            confLogIn = await logIn(email: _email, password: _password);
            //CONTROL SI SON NULOS
            if (confLogIn == 'true') {
              String uid = FirebaseAuth.instance.currentUser.uid;
              String id = await getIdWithUid(uid: uid);
              DocumentSnapshot user = await getUser(id: id);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewUserPage(id: id, user: user)),
              );
            }
          }
        }
      } else if (conf.contains('Error en el registro')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text('Ha ocurrido un error'),
                  content: new Text(conf),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'De acuerdo.',
                        style: TextStyle(color: CustomColor.mainColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text('Vaya...'),
                  content: new Text(conf),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'De acuerdo.',
                        style: TextStyle(color: CustomColor.mainColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  Future<String> getUserId(context, String email, String pw) async {
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      dynamic document = await databaseReference
          .collection('users')
          .where('Correo', isEqualTo: email)
          .where('Contraseña', isEqualTo: pw)
          .get();

      if (document.docs.isEmpty) {
        return null;
      } else {
        return document.docs[0].id;
      }
    } catch (e) {
      /*showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Ha ocurrido un error'),
                content: new Text(
                    'Si el problema persiste, póngase en contacto con nosotros.\n- getUserId - Código de error: ' +
                        e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));*/

      print('Error en GETUSERID: ' + e.toString());
    }
  }

  Future<bool> checkIfExists(context, String email, String dni) async {
    // }
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      dynamic documentDni = await databaseReference
          .collection('users')
          .where('DNI', isEqualTo: email)
          .get();
      dynamic emailDocument = await databaseReference
          .collection('users')
          .where('Correo', isEqualTo: email)
          .get();

      if (!documentDni.docs.isEmpty || !emailDocument.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      /*showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Ha ocurrido un error'),
                content: new Text(
                    'Si el problema persiste, póngase en contacto con nosotros.\n- checkIfExists - Código de error: ' +
                        e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));*/
      print('Error en CHECKIFEXISTS: ' + e.toString());
      //return id;
      //popup error
    }
  }
}
