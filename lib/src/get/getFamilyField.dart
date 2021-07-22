// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class GetFamilyField extends StatelessWidget {
//   final String documentId;
//   final String field;
//   final double fontSize;
//   final bool bold;

//   GetFamilyField({@required this.documentId, @required this.field, this.fontSize, this.bold});

//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp();
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('families');

//     return FutureBuilder<DocumentSnapshot>(
//         future: users.doc(documentId).get(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("Something went wrong");
//           }
//           if (!snapshot.hasData) {
//             return Text('');
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data = snapshot.data.data();
//             //return str("${data[field]}");
//             if (data != null) {
//               if (fontSize != null) {
//                 if (bold == true) {
//                   return Text(
//                     "${data[field]}",
//                     style: TextStyle(
//                         fontSize: fontSize, fontWeight: FontWeight.bold),
//                   );
//                 } else {
//                   return Text(
//                     "${data[field]}",
//                     style: TextStyle(fontSize: fontSize),
//                   );
//                 }
//               }
//               if (bold != true) {
//                 return Text(
//                   "${data[field]}",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 );
//               } else {
//                 return Text("${data[field]}");
//               }
//             }
//           }
//           return Text("loading");
//         });
//   }
// }
