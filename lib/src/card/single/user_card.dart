import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/flutterFire/flutterfire.dart';
import 'package:homeconomy/src/get/getUserField.dart';

class UserCard extends StatelessWidget {
  UserCard({@required this.id, @required this.user});
  final String id;
  final DocumentSnapshot user;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    // getUserFieldWithId(id: _id, field: 'Nombre').then((value) => _name = value);
    // getUserFieldWithId(id: _id, field: 'Apellidos')
    //     .then((value) => _surname = value);
    // getUserFieldWithId(id: _id, field: 'Imagen')
    //     .then((value) => _imageUrl = value);

    // String _name = user.data()['Nombre'].toString();
    // String _surname = user.data()['Apellido'].toString();

    // dynamic _name = FutureBuilder(
    //   future: user,
    //   builder:
    //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }

    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data.data();
    //       final String txt = "${data['Nombre']}";
    //       return Text(txt);
    //       //return Text("${data[field]}");
    //     }

    //     return Text("loading");
    //   },
    // );

    // dynamic _name = GetUserField(id: id, field: 'Nombre');
    // dynamic _surname = GetUserField(id: id, field: 'Apellidos');

    return SafeArea(
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final allFields = snapshot.data;
            if (snapshot.hasData) {
              dynamic nombre = allFields['Nombre'];
              dynamic apellidos = allFields['Apellidos'];
              dynamic urlImagen = allFields['Imagen'];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15.0, top: 11.0),
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
                        //width: 120,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20.0, 3.5, 20.0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10.0),
                                Text(nombre),
                                Text(apellidos),
                              ]),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: _height * 0.007, right: _height * 0.005),
                    padding: EdgeInsets.fromLTRB(0, _height * 0.02, 10.0, 15.0),
                    child: CircleAvatar(
                      backgroundImage: urlImagen == null
                          ? AssetImage('assets/random_user.png')
                          : new NetworkImage(user['Imagen']),
                      child: null, //_image,
                      radius: 30,
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColor.shadowColor,
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(45),
                      //   child: CachedNetworkImage(
                      //     imageUrl: this._imageUrl,
                      //     //placeholder: new CircularProgressIndicator(),
                      //     //errorWidget: new Icon(Icons.error),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
