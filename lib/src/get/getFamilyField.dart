import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GetFamilyField extends StatelessWidget {
  final String documentId;
  final String field;

  GetFamilyField(this.documentId, this.field);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    CollectionReference users =
        FirebaseFirestore.instance.collection('families');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              //return str("${data[field]}");
              return Text("${data[field]}");
            }

            return Text("loading");
          },
    );
  }
}
