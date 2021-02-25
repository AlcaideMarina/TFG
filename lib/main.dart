import 'package:flutter/material.dart';
import 'package:homeconomy/src/pages/home_page.dart';
import 'package:homeconomy/src/pages/login_page.dart';

void main() => runApp(MyApp());

  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      home: HomePage(),
    );
  }
}