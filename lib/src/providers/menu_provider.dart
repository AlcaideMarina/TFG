import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/pages/init_page.dart';
import 'package:homeconomy/src/pages/login_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';
import 'package:homeconomy/src/pages/menu_pages/myCategories_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newExpense_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newIncome_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';

class MenuProvider extends StatefulWidget {
  MenuProvider(
      {Key key,
      @required this.id,
      @required this.user,
      @required this.currentPage})
      : super(key: key);
  final String id;
  final DocumentSnapshot user;
  final String currentPage;

  @override
  MenuProviderState createState() => MenuProviderState(id, user, currentPage);
}

bool homePage;
bool familyPage;
bool newExpensePage;
bool newIncomePage;
bool messagesPage;
bool myProfilePage;
bool settingsPage;

//focus(currentPage);
class MenuProviderState extends State<MenuProvider> {
  MenuProviderState(this._id, this.user, this.currentPage);
  final String _id;
  final DocumentSnapshot user;
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    // dynamic _name = GetUserField(
    //     id: _id, field: 'Nombre', fontSize: 22.0, color: Colors.white);

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: SafeArea(child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_id)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  final allFields = snapshot.data;
                  if (snapshot.hasData) {
                    String nombre = allFields['Nombre'];
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hola,',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(nombre, style: TextStyle(color: Colors.white, fontSize: 20.0),)
                        ]);
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                })),

            //padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0)
            alignment: Alignment.centerLeft,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              CustomColor.mainColor,
              CustomColor.gradientColor
            ]),
          ),
        ),
        ListTile(
          title: Text(
            'Mi perfil',
          ),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'HomePage' ? true : false,
          selectedTileColor: currentPage == 'HomePage'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: CustomColor.mainColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(id: _id, user: user)),
            );
          },
        ),
        ListTile(
          title: Text('Mi familia'),
          //autofocus: true,
          //focusColor: Colors.red[100],

          selected: currentPage == 'FamilyPage' ? true : false,
          selectedTileColor: currentPage == 'FamilyPage'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () async {
            String uid = FirebaseAuth.instance.currentUser.uid;
            String id = await getIdWithUid(uid: uid);
            DocumentSnapshot user = await getUser(id: id);
            String familyId =
                await getUserFieldWithId(id: _id, field: 'FamilyID');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FamilyPage(
                        familyId: familyId,
                        user: user,
                        userId: _id,
                      )),
            );
          },
        ),
        ListTile(
          title: Text('Nuevo gasto'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'NewExpensePage' ? true : false,
          selectedTileColor: currentPage == 'NewExpensePage'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () async {
            String uid = FirebaseAuth.instance.currentUser.uid;
            String id = await getIdWithUid(uid: uid);
            DocumentSnapshot user = await getUser(id: id);
            String familyId =
                await getUserFieldWithId(id: _id, field: 'FamilyID');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewExpensePage(
                          id: _id,
                          user: user,
                          familyId: familyId,
                        )));
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Nuevo ingreso'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'NewIncomePage' ? true : false,
          selectedTileColor: currentPage == 'NewIncomePage'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () async {
            String uid = FirebaseAuth.instance.currentUser.uid;
            String id = await getIdWithUid(uid: uid);
            DocumentSnapshot user = await getUser(id: id);
            String familyId =
                await getUserFieldWithId(id: _id, field: 'FamilyID');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewIncomePage(
                          id: _id,
                          user: user,
                          familyId: familyId,
                        )));
            // Update the state of the app.
            // ...
          },
        ),
        // ListTile(
        //   title: Text('Mensajes'),
        //   //autofocus: true,
        //   //focusColor: Colors.red[100],
        //   selected: currentPage == 'MessagePage' ? true : false,
        //   selectedTileColor: currentPage == 'MessagePage'
        //       ? CustomColor.backgroundColor
        //       : Colors.white,
        //   //tileColor: Colors.red[50],
        //   hoverColor: Colors.teal,
        //   onTap: () {
        //     // Update the state of the app.
        //     // ...
        //   },
        // ),
        ListTile(
          title: Text('Mis categorías'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'MyCategories' ? true : false,
          selectedTileColor: currentPage == 'MyCategories'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyCategoriesPage(id: _id, user: user)),
            );
          },
        ),
        // ListTile(
        //   title: Text('Mi perfil'),
        //   //autofocus: true,
        //   //focusColor: Colors.red[100],
        //   selected: currentPage == 'MyProfilePage' ? true : false,
        //   selectedTileColor: currentPage == 'MyProfilePage'
        //       ? CustomColor.backgroundColor
        //       : Colors.white,
        //   //tileColor: Colors.red[50],
        //   hoverColor: Colors.teal,
        //   onTap: () {
        //     //Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),)
        //   },
        // ),
        ListTile(
          title: Text('Ajustes'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'SettingsPage' ? true : false,
          selectedTileColor: currentPage == 'SettingsPage'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () async {
            String uid = FirebaseAuth.instance.currentUser.uid;
            String id = await getIdWithUid(uid: uid);
            DocumentSnapshot user = await getUser(id: id);
            String familyId =
                await getUserFieldWithId(id: _id, field: 'FamilyID');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SettingsPage(user: user, id: _id, familyId: familyId)),
            );
          },
        ),
        ListTile(
          title: Text('Cerrar sesión'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'SignOut' ? true : false,
          selectedTileColor: currentPage == 'SignOut'
              ? CustomColor.backgroundColor
              : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InitPage()),
            );
          },
        ),
      ],
    ));
  }
}
/*
void focus(currentPage) {
  if (currentPage == 'HomePage') {
    homePage = true;
    familyPage = false;
    newExpensePage = false;
    newIncomePage = false;
    messagesPage = false;
    myProfilePage = false;
    settingsPage = false;
  }
  if (currentPage == 'FamilyPAge') {
    homePage = false;
    familyPage = true;
    newExpensePage = false;
    newIncomePage = false;
    messagesPage = false;
    myProfilePage = false;
    settingsPage = false;
  }
  if (currentPage == 'NewExpensePage') {
    homePage = false;
    familyPage = false;
    newExpensePage = true;
    newIncomePage = false;
    messagesPage = false;
    myProfilePage = false;
    settingsPage = false;
  }
  if (currentPage == 'NewIncomePage') {
    homePage = false;
    familyPage = false;
    newExpensePage = false;
    newIncomePage = true;
    messagesPage = false;
    myProfilePage = false;
    settingsPage = false;
  }
  if (currentPage == 'MessagesPage') {
    homePage = false;
    familyPage = false;
    newExpensePage = false;
    newIncomePage = false;
    messagesPage = true;
    myProfilePage = false;
    settingsPage = false;
  }
  if (currentPage == 'MyProfilePage') {
    homePage = false;
    familyPage = false;
    newExpensePage = false;
    newIncomePage = false;
    messagesPage = false;
    myProfilePage = true;
    settingsPage = false;
  }
  if (currentPage == 'SettingsPage') {
    homePage = false;
    familyPage = false;
    newExpensePage = false;
    newIncomePage = false;
    messagesPage = false;
    myProfilePage = false;
    settingsPage = true;
  }
}*/
