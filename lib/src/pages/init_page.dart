import 'package:auth/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/pages/register_page.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'menu_pages/home_page.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  void initState() {
      super.initState();
      //GoogleSignIn();
      //GoogleSignInProvider
  }

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

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final topBackground = Container(
        height: _height * 0.55,
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          CustomColor.mainColor,
          CustomColor.gradientColor
        ])));

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(children: [
          topBackground,
          // SafeArea(
          //   child: Image.asset('assets/letrasBlanco.png',
          //       width: double.infinity, scale: 1.5),
          // ),
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
            padding: EdgeInsets.only(top: _height * 0.2),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: _width * 0.8,
                        margin:
                            EdgeInsets.only(top: _height * 0.1, bottom: 15.0),
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color:
                                    Colors.black26, //CustomColor.shadowColor,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 5.0)),
                          ],
                        ),
                        child: Column(children: [
                          Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                      child: Text('Acceder con correo'),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0)))),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              CustomColor.mainColor),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          overlayColor: MaterialStateProperty.all<Color>(
                                              CustomColor.softColor),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0))),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.email_outlined,
                                          color: CustomColor.mainColor,
                                        ),
                                        iconSize: 40.0),
                                  ])),
/*                            SizedBox(
                            height: 20.0,
                          ),
                        Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // signInWithGoogle(context: context);
                                        //signInWithGoogle();
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           SignInGoogle()),
                                        // );
                                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                        provider.googleLogin();
                                      },
                                      child: Text('Acceder con Google'),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0)))),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              CustomColor.mainColor),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          overlayColor: MaterialStateProperty.all<Color>(
                                              CustomColor.softColor),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0))),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                            'assets/google-logo.png'),
                                        iconSize: 40.0),
                                  ])),*/
                          SizedBox(height: 30.0),
                          Text('¿No tienes cuenta?'),
                          SizedBox(height: 20.0),
                          Container(
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()),
                                        );
                                      },
                                      child: Text(
                                        'Regístrate con un correo',
                                      ),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0)))),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              CustomColor.darkColor),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          overlayColor: MaterialStateProperty.all<Color>(
                                              CustomColor.softColor),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(horizontal: 16.5, vertical: 20.0))),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.email_outlined,
                                          color: CustomColor.darkColor,
                                        ),
                                        iconSize: 40.0),
                                  ])),
                        ])),
                  ],
                ),
              ),
            ),
          ),
          // ),
          
        ]));
  }

}
