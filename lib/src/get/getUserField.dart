// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// /*
// class GetUserField extends StatefulWidget {
//   GetUserField({Key key, @required this.id, @required this.field})
//       : super(key: key);
//   final String id;
//   final String field;
//   String txt;

//   @override
//   _GetUserFieldState createState() => _GetUserFieldState(id, field, txt);
// }

// class _GetUserFieldState extends State<GetUserField> {
//   _GetUserFieldState(String id, String field, String txt);
//   String id;
//   String field;
//   Widget txt;

//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp();
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//     if (field != null && id != null) {
//       return Container(
//         child: FutureBuilder<DocumentSnapshot>(
//           future: users.doc(id).get(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return txt;
//             }

//             if (snapshot.connectionState == ConnectionState.done) {
//               Map<String, dynamic> data = snapshot.data.data();
//               txt = Text("${data[field]}");
              
//               return txt;
//             }

//             return Text("loading");
//           },
//         ),
//       );
//     }
//   }
// }

// */

// class GetUserField extends StatelessWidget {
//   final String id;
//   final String field;
//   final double fontSize;
//   final Color color;

//   GetUserField({this.id, this.field, this.fontSize, this.color});

//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp();
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(id).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//         if (!snapshot.hasData) {
//           return Text('');
//         } else if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           if (data != null) {
//             final String txt = "${data[field]}";
//             if (fontSize != null) {
//               if (color != null) {
//                 return Text(
//                   txt,
//                   style: TextStyle(fontSize: fontSize, color: color),
//                 );
//               }
//               else{
//                 return Text(
//                   txt,
//                   style: TextStyle(fontSize: fontSize),
//                 );
//               }
//             } else if(color != null) {
//               return Text(
//                   txt,
//                   style: TextStyle(color: color),
//                 );
//             } 
//             else {
//               return Text(txt);
//             }
//           }
//         }
//         return Text("loading");
//       },
//     );
//   }
// }
