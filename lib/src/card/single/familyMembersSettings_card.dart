import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/get/getFamilyField.dart';
import 'package:homeconomy/src/get/getListField.dart';
import 'package:homeconomy/src/get/getUserField.dart';

class FamilyMemberSettingsCard extends StatelessWidget {
  FamilyMemberSettingsCard(
      {Key key, @required this.memberId, @required this.user})
      : super(key: key);
  final String memberId;
  final DocumentSnapshot user;

  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(memberId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final allFields = snapshot.data;
            if (snapshot.hasData) {
              String nombre = allFields['Nombre'];
              String apellidos = allFields['Apellidos'];
              String urlImagen = allFields['Imagen'];

              return Container(
                height: 80.0,
                child: // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    Container(
                  padding: EdgeInsets.only(top: 11.0),
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              //width: _width * 0.4,
                                padding: EdgeInsets.fromLTRB(20.0, 3.5, 30.0, 0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.0),
                                      Text(nombre),
                                      Text(apellidos),
                                    ]),
                                alignment: Alignment.centerLeft,
                              ),
                            Expanded(child: SizedBox(),),
                            // IconButton(
                            //   //height: 60,
                            //   //width: _width * 0.55,
                            //   padding: EdgeInsets.fromLTRB(20.0, .5, 15.0, 0),
                            //   alignment: Alignment.centerRight,
                            //   icon: Icon(Icons.edit_rounded),
                              
                            //   onPressed: () {},
                            // ),
                            IconButton(
                              //height: 60,
                              //width: _width * 0.55,
                              padding: EdgeInsets.fromLTRB(0.0, 10.5, 15.0, 0),
                              alignment: Alignment.centerRight,
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {},
                            )
                          ])),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
