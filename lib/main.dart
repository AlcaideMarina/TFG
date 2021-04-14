import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';
import 'package:homeconomy/src/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homeconomy/src/pages/newUser_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('as', ''), // Arabic, no country code
        const Locale.fromSubtags(
            languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      color: Colors.teal,
      //home: NewUserPage(id: 'n6AjBMiO90ykZxPiWurt'),
      home: LoginPage(),
      //home: HomePage(),
    );
  }
}
