import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/signin_page.dart';

import 'menu_pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _pw = '';
  bool validation = false;
  String _isIncorrect = "";
  bool _isChecked = false;
  String value = "";
  changeText(String value) {
    setState(() {
      _isIncorrect = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 175.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //_campoEmail(),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      changeText('Debe introducir una correo');
                      return null;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'tuemail@dominio.com',
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.alternate_email),
                      icon: Icon(Icons.email)),
                  onChanged: (valor) {
                    setState(() {
                      _email = valor;
                    });
                  },
                ),
                Divider(),
                //_campoPassword(),
                TextFormField(
                  obscureText: true,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return changeText('Debe introducir una contraseña');
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                      suffixIcon: Icon(Icons.lock_open),
                      icon: Icon(Icons.lock)),
                  onChanged: (valor) {
                    setState(() {
                      _pw = valor;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                Text('$_isIncorrect'),
                //SizedBox(height: 15.0),
                CheckboxListTile(
                  title: Text(
                    "Recuérdame",
                    textAlign: TextAlign.right,
                  ),
                  value: _isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _isChecked = newValue;
                    });
                  },
                  dense: true,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_email == "") {
                      if (_pw == "") {
                        return changeText(
                            'Debe introducir su correo y contraseña');
                      } else {
                        return changeText('Debe introducir un correo');
                      }
                    } else if (_pw == "") {
                      return changeText('Debe introducir una contraseña');
                    } else {
                      access(_email, _pw);
                      bool conf = await logIn(_email, _pw);
                      if (conf == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute( // VAS POR AQUÍ
                              builder: (context) => HomePage(id: FirebaseAuth.instance.currentUser.uid),)
                        );
                      }
                    }
                  },
                  child: Text('Acceder'),
                  textColor: Colors.white,
                  color: Colors.teal,
                ),
                SizedBox(height: 15.0),
                ElevatedButton(
                    onPressed: () {
                      if (_isChecked == false) {
                        _email = "";
                        _pw = "";
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      );
                    },
                    child: Text('No tengo cuenta. Registrarme.'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.teal[10]),
                        //side: MaterialStateProperty.all<BorderSide>(),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)))
                    //color: Colors.transparent,
                    //elevation: 0.0,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void access(String mail, String pw) async {
    checkIfExists(mail, pw).then((String id) async {
      if (id == null) {
        changeText('Correo o contraseña incorrectos');
      } else if (id.contains('Error')) {
        changeText('Ha habido un error, por favor, inténtelo más tarde. ' + id);
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mail, password: pw);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(id: id)),
        );
      }
    });
  }
}

Future<String> checkIfExists(String email, String pw) async {
  // if (email == 'marina@gmail.com' && pw == 'marina') {
  //   String id = 'prueba';
  //   return id;
  // }
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
    String id = 'Error: ' + e.toString();
    return id;
  }
}
/*
Future<User> singIn(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.signInWithEmailAndPassword(
        email: email, password: password).then((credentials) {
    String userID = credentials.user.uid});
    print("User id is ${user.uid}");
    return user;
  }*/
