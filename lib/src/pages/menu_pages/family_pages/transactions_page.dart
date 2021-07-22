// import 'package:charts_flutter/flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TransactionsFamilyPage extends StatefulWidget {
//   TransactionsFamilyPage(
//       {Key key,
//       @required this.familyId,
//       @required this.user,
//       @required this.userId})
//       : super(key: key);
//   final String familyId;
//   final DocumentSnapshot user;
//   final String userId;

//   @override
//   _TransactionsFamilyPageState createState() =>
//       _TransactionsFamilyPageState(familyId, user, userId);
// }

// class _TransactionsFamilyPageState extends State<TransactionsFamilyPage> {
//   final String familyId;
//   final DocumentSnapshot user;
//   final String userId;
//   _TransactionsFamilyPageState(this.familyId, this.user, this.userId);

//   bool vacio = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             SafeArea(
//                 child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('families')
//                   .doc(familyId)
//                   .snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                 final allField = snapshot.data;
//                 if (snapshot.hasData) {
//                   List<dynamic> miembros = allField['members'];
//                   return Expanded(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         //scrollDirection: Axis.vertical,
//                         itemCount: miembros.length,
//                         itemBuilder: (context, index) {
//                           return Text('transacciones');
//                         }),
//                   );
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
