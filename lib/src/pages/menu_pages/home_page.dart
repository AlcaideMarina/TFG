import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/src/get/getUser.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/menu_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';
import 'package:homeconomy/src/providers/menu_provider.dart';
import 'package:homeconomy/src/utils/graph_card.dart';
import 'package:homeconomy/src/utils/money_card.dart';

import 'package:homeconomy/src/pages/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({@required this.id});
  final String id;

  @override
  _HomePageState createState() => _HomePageState(id);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this._id);
  final String _id;
  final GlobalKey _menuKey = new GlobalKey();
  //GetUserField _name;
  String _name;
  GetUserField _surname;
  DocumentSnapshot getUser;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    //Future<dynamic> user = getUser(widget.id);

    
    Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    // users
    //   .doc(_id)
    //   .get()
    //   .then((DocumentSnapshot documentSnapshot) {
    //     if (documentSnapshot.exists){
    //       getUser = documentSnapshot;
    //     }
        
    //   });
    // //getUser = GetUser(id: _id);
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance.collection('COLLECTION_NAME').doc('TESTID1').snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return new Text("Loading");
    //     }
    //     var userDocument = snapshot.data;
    //     return new Text(userDocument["name"]);
    //   }
    //);

    //Widget _name = buildUser(context, _id, 'Nombre');
    //_name = GetUserField(id: _id, field: 'Nombre');
    _name = GetUser(id: _id, field: 'Nombre').getString(context);
    if(_name == null) {
      _name = 'problema con _name';
    }
    _surname = GetUserField(id: _id, field: 'Apellidos');

    //getField(_id, 'Nombre').then((Widget _name) => setState((){this._name = _name;}));
    //Widget nombre = getField(_id, 'Nombre');
    //buildUser(context, _id, 'Nombre').then((value) => _name = value);
    //String _surname = ''; // buildUser(context, _id, 'Apellidos');
    //Widget _image = buildUser(context, _id, 'Imagen');

    return Scaffold(
      drawer: MenuProvider(id: _id, currentPage: 'HomePage'),
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
      
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        toolbarHeight: 90.0,
        backgroundColor: Colors.teal[50],
        elevation: 0.0,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 15.0, top: 15.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: //Column(
                      //children: [
                      //SizedBox()
                      Container(
                    height: 60,
                    width: 120,
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 10.0),
                            //Text(_name),
                            //_surname,
                            //_name,
                            _surname,
                          ]),
                      alignment: Alignment.center,
                    ),
                    // child: Align(
                    //   alignment: Alignment(0, 0),
                    //   child: Column(children: [Text('Marina'), Text('Alcaide')],)
                    //Container(
                    //child: Text(
                    //'Marina',
                    //),
                    //),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15.0, 10.0, 15.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/random_user.png'), // Esto no he conseguido meterlo desde la bbdd
                  radius: 30,
                  foregroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[CardMoney(id: _id), Divider(), GraphCard()],
      ),
    );
  }
}

class User {
  String idUser;
  //String nombre = getUserField(idUser, nombre);
}

Future<String> getUser(String id) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    dynamic document = databaseReference.collection('users').doc(id).get();
    return document;
    //print(document.documents[0].documentID);                VAS POR AQUÍ
    // if (document.isEmpty) {
    //   return null;
    // } else {
    //   return document.documents[0].documentID;
    // }

  } catch (e) {
    String id = 'Error: ' + e.toString();
    print(id);
    return id;
  }
}

Future<Widget> getField(String id, String field) async {
  await Firebase.initializeApp();
  return FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance.collection('users').doc(id).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data.data();
        return Text("${data['Nombre']}");
      }

      return Text("loading");
    },
  );
}
//var userDocument = snapshot.data;
//  return new Text(userDocument[field]);

void user() {
  final String _collection = 'collectionName';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  getData() async {
    return await _fireStore.collection(_collection).get();
  }

  getData().then((val) {
    if (val.docs.length > 0) {
      print('BUSCA ESTO');
      print(val.docs[0].data()['Nombre']);
    } else {
      print("Not Found");
    }
  });
}

Future<String> getUserId(String id) async {
  try {
    await Firebase.initializeApp();
    String algo;
    final user = FirebaseFirestore.instance.collection("users").doc(id).get();
    print(user.then((value) => algo = value.get('Nombre')));
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}
/*
void prueba()async{
  var user = await FirebaseAuth.instance.currentUser;
      var userQuery = FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, isEqualTo: user.uid).limit(1);
      userQuery.get().then((data) { 
          if (data != null){
                    String firstName = data.data()['firstName'];
                    String lastName = data.documents[0].data['lastName'];
                  };
          
}*/
