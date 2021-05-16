import 'package:flutter/material.dart';
import 'package:homeconomy/src/get/getFamilyField.dart';
import 'package:homeconomy/src/get/getUserField.dart';
import 'package:homeconomy/src/utils/graph_card.dart';
import 'package:homeconomy/src/utils/money_card.dart';

class FamilyPage extends StatefulWidget {
  FamilyPage({@required this.id});
  final String id;
  @override
  _FamilyPageState createState() => _FamilyPageState(id);
}

class _FamilyPageState extends State<FamilyPage> {
  _FamilyPageState(this._id);
  final String _id;
  final GlobalKey _menuKey = new GlobalKey();
  @override

  
  String _familyId;
  GetFamilyField _name;
String hola ;
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;


    //Widget _name = buildUser(context, _id, 'Nombre');
    //_familyId = GetUserField(id: _id, field: 'FamilyID').txt
    //_familyId = 
    //GetUserField(_id, 'FamilyID');
    //; //VAS POR AQUÍ, LO QUE ESTABAS HACIENDO ES PASAR ESTO A TEXTO, PARA ESO NECESITAS QUE LA CLASE GetFamilyField Y GetUserField GUARDEN STRING CON UN .VARIABLEQUEGUARDASTRING CON EL DATO QUE NECESITAS. PARA ESO ANTES NECESITAS PASAR ESTAS DOS CLASES A STATEFULL WIDGET
   // _name = GetFamilyField(_familyId, 'Name');
 _name = GetFamilyField(_id, 'Name');
    return Scaffold(
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
        children:[ Text('Prueba')]//<Widget>[CardMoney(id: _id), Divider(), GraphCard()],
      ),
    );
  }
}