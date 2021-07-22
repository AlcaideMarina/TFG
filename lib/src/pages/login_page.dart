import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/register_page.dart';

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
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    final topBackground = Container(
        height: _height * 0.55,
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          CustomColor.mainColor,
          CustomColor.gradientColor
        ])));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          topBackground,
          SafeArea(
            child: Image.asset('assets/letrasBlanco.png',
                width: double.infinity, scale: 1.5),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: _height * 0.2),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: _width * 0.86,
                      margin:
                          EdgeInsets.only(top: _height * 0.07, bottom: 15.0),
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
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                          child: Column(
                            children: <Widget>[
                              //_campoEmail(),
                              Text(
                                'Inicio sesión',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: CustomColor.mainColor),
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                cursorColor: CustomColor.mainColor,
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
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    hintText: 'tuemail@dominio.com',
                                    labelText: 'Email',
                                    icon: Icon(
                                      Icons.alternate_email,
                                      size: 18.0,
                                    )),
                                onChanged: (valor) {
                                  setState(() {
                                    _email = valor;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                cursorColor: CustomColor.mainColor,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    hintText: 'Contraseña',
                                    labelText: 'Contraseña',
                                    icon: Icon(
                                      Icons.lock_outline,
                                      size: 18.0,
                                    )),
                                onChanged: (valor) {
                                  setState(() {
                                    _pw = valor;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
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
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    String txtError = '';
                                    if (_email == "") {
                                      if (_pw == "") {
                                        txtError =
                                            'Debe introducir un correo y una contraseña.';
                                      } else {
                                        txtError = 'Debe introducir un correo.';
                                      }
                                    } else if (_pw == "") {
                                      txtError =
                                          'Debe introducir una contraseña.';
                                    }
                                    if (txtError != '') {
                                      showDialog(
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                                title: new Text(
                                                    'Revise los datos'),
                                                content: new Text(txtError),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                      'De acuerdo.',
                                                      style: TextStyle(
                                                          color: CustomColor
                                                              .mainColor),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              ));
                                    } else {
                                      //access(_email, _pw);
                                      bool conf =
                                          EmailValidator.validate(_email);
                                      if (conf == true) {
                                        String confLogIn;
                                        confLogIn = await logIn(
                                            email: _email, password: _pw);
                                        //CONTROL SI SON NULOS
                                        if (confLogIn == 'true') {
                                          String uid = FirebaseAuth
                                              .instance.currentUser.uid;
                                          String id =
                                              await getIdWithUid(uid: uid);
                                          DocumentSnapshot user =
                                              await getUser(id: id);
                                          // if (_isChecked == false) {
                                          //   _email = "";
                                          //   _pw = "";
                                          // }
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                // VAS POR AQUÍ
                                                builder: (context) => HomePage(
                                                    id: id, user: user),
                                              ));
                                        } else if (confLogIn == 'false') {
                                          showDialog(
                                              context: context,
                                              builder: (_) => new AlertDialog(
                                                    title: new Text('Vaya...'),
                                                    content: new Text(
                                                        'Correo o contraseña incorrecto.'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                          'De acuerdo.',
                                                          style: TextStyle(
                                                              color: CustomColor
                                                                  .mainColor),
                                                        ),
                                                        onPressed: () {
                                                          
                                                          Navigator.of(context)
                                                              .pop();
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
                                                        'Ha ocurrido un error.\n' + confLogIn),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                          'De acuerdo.',
                                                          style: TextStyle(
                                                              color: CustomColor
                                                                  .mainColor),
                                                        ),
                                                        onPressed: () {
                                                          
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ));
                                        }
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => new AlertDialog(
                                                  title: new Text('Vaya...'),
                                                  content: new Text(
                                                      'El formato del correo no es correcto.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'De acuerdo.',
                                                        style: TextStyle(
                                                            color: CustomColor
                                                                .mainColor),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                ));
                                      }
                                    }
                                  },
                                  child: Text('Acceder'),
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
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 70.0, vertical: 15.0)),
                                  )),
                              SizedBox(height: 10.0),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){}, 
                      child: Text('¿Has olvidado la contraseña?'),
                      style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(CustomColor.darkColor)), 
                    ),
                    //Text('¿Has olvidado la contraseña?'), //SIN IMPLEMENTAR
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
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
          // ),
        ]));
  }

//   void access(String mail, String pw) async {
//     checkIfExists(mail, pw).then((String id) async {
//       if (id == null) {
//         changeText('Correo o contraseña incorrectos');
//       } else if (id.contains('Error')) {
//         changeText('Ha habido un error, por favor, inténtelo más tarde. ' + id);
//       } else {
//         await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: mail, password: pw);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage(id: id)),
//         );
//       }
//     });
//   }
// }

// Future<String> checkIfExists(String email, String pw) async {
//   try {
//     await Firebase.initializeApp();
//     final databaseReference = FirebaseFirestore.instance;
//     dynamic document = await databaseReference
//         .collection('users')
//         .where('Correo', isEqualTo: email)
//         .where('Contraseña', isEqualTo: pw)
//         .get();

//     if (document.docs.isEmpty) {
//       return null;
//     } else {
//       return document.docs[0].id;
//     }
//   } catch (e) {
//     String id = 'Error: ' + e.toString();
//     return id;
//   }
}
