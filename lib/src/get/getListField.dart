// //import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:homeconomy/src/card/single/familyMembers_card.dart';
// import 'package:homeconomy/src/card/single/user_card.dart';
// import 'package:homeconomy/src/get/getUserField.dart';
// import 'package:homeconomy/src/models/user_model.dart';

// class GetFamilyMembers extends StatelessWidget {
//   GetFamilyMembers({Key key, this.documentId, this.field}) : super(key: key);
//   final String documentId;
//   final String field;

//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp();
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('families');

//     Future getFuture() async {
//       QuerySnapshot qs =
//           await FirebaseFirestore.instance.collection('families').get();
//       return qs.docs;
//     }

//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('families')
//           .doc(documentId)
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         final allField = snapshot.data;
//         if (snapshot.hasData) {
//           List<dynamic> miembros = allField['members'];
//           return Expanded(
//                       child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//                       //itemExtent: 120,
//                       itemCount: miembros.length,
//                       //itemCount: 2,
//                       itemBuilder: (context, i) {
//                         return FamilyMembersCard(memberId: miembros[i]);
                        
//                         //ListTile(title: GetFamilyMembers(id: user.id, ));
//                       }),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//         return Text('hola');
//       },
//     );
//   }
// }
