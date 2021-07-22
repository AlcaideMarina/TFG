import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeconomy/custom/customColor.dart';
import 'package:homeconomy/src/get/getFamilyField.dart';

class FamilyCard extends StatelessWidget {
  const FamilyCard({@required this.familyId, @required this.familyDocument});
  final String familyId;
  final DocumentSnapshot familyDocument;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    // dynamic _name = GetFamilyField(
    //   documentId: familyId,
    //   field: 'surnames',
    //   fontSize: 15.0,
    // );

    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('families')
              .doc(familyId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final allFields = snapshot.data;
            if (snapshot.hasData) {
              dynamic nombre = allFields['surnames'];
              return Row(
                //textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Container(
                  //   padding: EdgeInsets.only(right: 15.0, top: 11.0),
                  //   child:
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(20.0, 2.5, 20.0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10.0),
                              Text(
                                'Familia',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(nombre),
                            ]),
                        alignment: Alignment.centerRight),
                    // child: Align(
                    //   alignment: Alignment(0, 0),
                    //   child: Column(children: [Text('Marina'), Text('Alcaide')],)
                    //Container(
                    //child: Text(
                    //'Marina',
                    //),
                    //),
                  ),
                  // ),
                  // ),
                  SizedBox(width: 10.0),
                  Container(
                    //margin: EdgeInsets.only(top: _height * 0.005, right: _height * 0.005),
                    padding: EdgeInsets.fromLTRB(0, 3.5, 0, 0),
                    child: CircleAvatar(
                      //backgroundImage: _imageUrl == 'assets/random_user.png' ? AssetImage(_imageUrl) : NetworkImage(_imageUrl),

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
              return Center(child: CircularProgressIndicator());
            }
          }),
    );

//     return Row(
//       //textDirection: TextDirection.ltr,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         // Container(
//         //   padding: EdgeInsets.only(right: 15.0, top: 11.0),
//         //   child:
//         Card(
//           elevation: 5.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),

//           child: Container(
//               height: 60,
//               padding: EdgeInsets.fromLTRB(20.0, 2.5, 20.0, 0),
//               child:
//                   Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//                 SizedBox(height: 10.0),
//                 Text(
//                   'Familia',
//                   style: TextStyle(fontSize: 12.0),
//                 ),
//                 SizedBox(
//                   height: 1.0,
//                 ),
//                 _name,
//               ]),
//               alignment: Alignment.centerRight),
//           // child: Align(
//           //   alignment: Alignment(0, 0),
//           //   child: Column(children: [Text('Marina'), Text('Alcaide')],)
//           //Container(
//           //child: Text(
//           //'Marina',
//           //),
//           //),
//         ),
//         // ),
//         // ),
//         SizedBox(width: 10.0),
//         Container(
//           //margin: EdgeInsets.only(top: _height * 0.005, right: _height * 0.005),
//           padding: EdgeInsets.fromLTRB(0, 3.5, 0, 0),
//           child: CircleAvatar(
//             //backgroundImage: _imageUrl == 'assets/random_user.png' ? AssetImage(_imageUrl) : NetworkImage(_imageUrl),

//             child: null, //_image,
//             radius: 30,
//             foregroundColor: Colors.white,
//             backgroundColor: CustomColor.shadowColor,
//             // child: ClipRRect(
//             //   borderRadius: BorderRadius.circular(45),
//             //   child: CachedNetworkImage(
//             //     imageUrl: this._imageUrl,
//             //     //placeholder: new CircularProgressIndicator(),
//             //     //errorWidget: new Icon(Icons.error),
//             //   ),
//             // ),
//           ),
//         ),
//       ],
//     );
  }
}
