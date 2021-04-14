import 'package:flutter/material.dart';
import 'package:homeconomy/src/pages/login_page.dart';
import 'package:homeconomy/src/pages/menu_pages/family_page.dart';
import 'package:homeconomy/src/pages/menu_pages/home_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newExpense_page.dart';
import 'package:homeconomy/src/pages/menu_pages/newIncome_page.dart';
import 'package:homeconomy/src/pages/menu_pages/settings_page.dart';

class MenuProvider extends StatefulWidget {
  MenuProvider({Key key, @required this.id, @required this.currentPage})
      : super(key: key);
  final String id;
  final String currentPage;

  @override
  MenuProviderState createState() => MenuProviderState(id, currentPage);
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
  MenuProviderState(this._id, this.currentPage);
  final String _id;
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Bienvenido', style: TextStyle(color: Colors.white)),
          decoration: BoxDecoration(color: Colors.teal),
          //padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0)
        ),
        ListTile(
          title: Text('Página principal'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'HomePage' ? true : false,
          selectedTileColor:
              currentPage == 'HomePage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(id: _id)),
            );
          },
        ),
        ListTile(
          title: Text('Página familiar'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'FamilyPage' ? true : false,
          selectedTileColor:
              currentPage == 'FamilyPage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FamilyPage(id: _id)),
            );
          },
        ),
        ListTile(
          title: Text('Nuevo gasto'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'NewExpensePage' ? true : false,
          selectedTileColor:
              currentPage == 'NewExpensePage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewExpensePage(id: _id)));
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Nuevo ingreso'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'NewIncomePage' ? true : false,
          selectedTileColor:
              currentPage == 'NewIncomePage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewIncomePage(id: _id)));
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Mensajes'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'MessagePage' ? true : false,
          selectedTileColor:
              currentPage == 'MessagePage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Mi perfil'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'MyProfilePage' ? true : false,
          selectedTileColor:
              currentPage == 'MyProfilePage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),)
          },
        ),
        ListTile(
          title: Text('Ajustes'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'SettingsPage' ? true : false,
          selectedTileColor:
              currentPage == 'SettingsPage' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        ListTile(
          title: Text('Cerrar sesión'),
          //autofocus: true,
          //focusColor: Colors.red[100],
          selected: currentPage == 'SignOut' ? true : false,
          selectedTileColor:
              currentPage == 'SignOut' ? Colors.teal[50] : Colors.white,
          //tileColor: Colors.red[50],
          hoverColor: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
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
