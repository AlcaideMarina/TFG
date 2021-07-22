// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';


// class GetUser   {
//   const GetUser({Key key, this.id, this.field});

//   final String id;
//   final String field;
  

//   //@override
//   String getString(BuildContext context) {

//     Firebase.initializeApp();
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

   

//     String userData;

//     FutureBuilder<DocumentSnapshot> (
//       future: users.doc(id).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//         if(!snapshot.data.exists){
//           return null;
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           userData = '${data[field]}';
//           return Text("${data[field]}");
//         }

//         return Text("loading");
//       },
//     );
//     if (userData != null){
//       return userData;
//     }
//     else {
//       return 'problema';
//     }

//     // return FutureBuilder<DocumentSnapshot>(
//     //   future: users.doc(id).get(),
//     //   builder:
//     //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

//     //     if (snapshot.hasError) {
//     //       return Text("Something went wrong");
//     //     }

//     //     if (snapshot.connectionState == ConnectionState.done) {
//     //       Map<String, dynamic> data = snapshot.data.data();
//     //       return snapshot.data;
//     //       //return Text("${data[field]}");
//     //     }

//     //     return Text("loading");
//     //   },
//     // );
//   }
// }