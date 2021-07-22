import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/get/getUserField.dart';

class FamilyMembersCard extends StatelessWidget {
  const FamilyMembersCard(
      {Key key, @required this.memberId, @required this.user})
      : super(key: key);

  final DocumentSnapshot user;
  final dynamic memberId;

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 15.0, top: 11.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            height: 60,
                            width: _width * 0.55,
                            //child: Container(
                            padding: EdgeInsets.fromLTRB(7.0, 3.5, 30.0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10.0),
                                  Text(nombre),
                                  Text(apellidos),
                                ]),
                            alignment: Alignment.centerRight,
                            //),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: _height * 0.007, right: _height * 0.005),
                        padding:
                            EdgeInsets.fromLTRB(0, _height * 0.013, 10.0, 5.0),
                        child: CircleAvatar(
                          backgroundImage: urlImagen == ""
                              ? AssetImage('assets/random_user.png')
                              : new NetworkImage(urlImagen),
                          child: null, //_image,
                          radius: 30,
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColor.shadowColor,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Container(
    //       padding: EdgeInsets.only(right: 15.0, top: 11.0),
    //       child: Card(
    //         elevation: 5.0,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //         child: Container(
    //           height: 60,
    //           width: _width * 0.55,
    //           child: Container(
    //             padding: EdgeInsets.fromLTRB(7.0, 3.5, 30.0, 0),
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   SizedBox(height: 10.0),
    //                   _nombre,
    //                   _apellidos,
    //                 ]),
    //             alignment: Alignment.centerRight,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.only(top: _height * 0.007, right: _height * 0.005),
    //       padding: EdgeInsets.fromLTRB(0, _height * 0.013, 10.0, 15.0),
    //       child: CircleAvatar(
    //         backgroundImage: user['Imagen'] == null
    //             ? AssetImage('assets/random_user.png')
    //             : new NetworkImage(user['Imagen']),
    //         child: null, //_image,
    //         radius: 30,
    //         foregroundColor: Colors.white,
    //         backgroundColor: CustomColor.shadowColor,
    //       ),
    //     ),
    //   ],
    // );

    // return Container(
    //   child: Card(
    //     elevation: 10.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(7.0),
    //     ),
    //     child: Container(
    //         width: _width * 0.6,
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             _nombre,
    //             _apellidos
    //           ],
    //         )),
    //   ),
    // );
  }
}
