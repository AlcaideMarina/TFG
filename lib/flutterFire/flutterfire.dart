import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

// api - prediccion
import 'dart:async'; // ya está importado arriba
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> logIn({String email, String password}) async {
  String resp;
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      
      resp = 'false';
    });
    if (resp == 'false') {
      return 'false';
    } else {
      return 'true';
    }
  } on FirebaseAuthException catch (e) {
    return 'Código de error: ' + e.toString();
  } catch (e) {
    return 'Código de error: ' + e.toString();
  }
}

Future<String> register({String email, String password}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return 'true';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'La contraseña debe tener, al menos, 6 caracteres.';
    } else if (e.code == 'email-already-in-use') {
      return 'Ya existe una cuenta con ese usuario.';
    }
    return 'Error en el registro: ' + e.toString();
  } catch (e) {
    return 'Error en el registro: ' + e.toString();
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

// Future<User> signInWithGoogle({BuildContext context}) async {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User user;

//   if (kIsWeb) {
//     GoogleAuthProvider authProvider = GoogleAuthProvider();

//     try {
//       final UserCredential userCredential =
//           await auth.signInWithPopup(authProvider);

//       user = userCredential.user;
//     } catch (e) {
//       print(e);
//     }
//   } else {
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         // if(e.code == 'account-exists-with-different-credential') {
//         //   p
//         // }
//         print(e.code);
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
// }

Future<String> updateUs(
    {String id,
    dynamic nombre,
    dynamic apellidos,
    dynamic laboral,
    dynamic fhNac,
    dynamic sexo,
    dynamic numTel}) async {
  try {
    String y = fhNac.substring(0, 4);
    String m = fhNac.substring(5, 7);
    String d = fhNac.substring(8, 10);

    String fhNac2 = y + '-' + m + '-' + d + ' 00:00:00.000';

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(id).update({
      'Nombre': nombre,
      'Apellidos': apellidos,
      'EstLaboral': laboral,
      'FchNacimiento': fhNac,
      'Sexo': sexo,
      'NTelefono': int.parse(numTel)
    });

    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> updateFam(
    {String familyId,
    dynamic apellidos,
    dynamic nombre,}) async {
  try {


    CollectionReference users = FirebaseFirestore.instance.collection('families');

    await users.doc(familyId).update({
      'familyName': nombre,
      'surnames': apellidos,
    });

    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> deleteFamilyUser({String familyId, String userId, List<dynamic> miembros}) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userId).update({'familyID': ''});

    CollectionReference families = FirebaseFirestore.instance.collection('families');
    miembros.remove(userId);
    await families.doc(familyId).update({'members': miembros});

    return 'true';
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> updateRec(
    {String id,
    String recordatorioId,
    String nombre,
    dynamic precio,
    String periodicidad,
    String fechaRecordatorio,
    bool tipoGasto}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('reminds')
        .doc(recordatorioId)
        .update({
      'FechaRecordar': fechaRecordatorio,
      'Nombre': nombre,
      'Periodicidad': periodicidad,
      'Precio': precio,
      'TipoGasto': tipoGasto
    });
    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> updateCat({String id, String categoryId, String nombre, String tipo, int color}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('categories')
        .doc(categoryId)
        .update({
      'Name': nombre,
      'Color': color,
      'Type': tipo
    });
    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> deleteRec({String id, String recordatorioId}) async {
  try {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('reminds')
        .doc(recordatorioId)
        .delete();
    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  }  catch (e) {
    return 'Error: ' + e.toString();
  }
}


Future<String> deleteCat({String id, String categoriaId}) async {
  try {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('categories')
        .doc(categoriaId)
        .delete();
    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  }  catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<String> deleteDocument({String collection, String id, String documentId}) async {
  try {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection(collection)
        .doc(documentId)
        .delete();
    return 'true';
  } on FirebaseAuthException catch (e) {
    return 'Error: ' + e.toString();
  }  catch (e) {
    return 'Error: ' + e.toString();
  }
}


Future<String> getIdWithUid({String uid}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    dynamic document = await databaseReference
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (document.docs.isEmpty) {
      return null;
    } else {
      return document.docs[0].id;
    }
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}

Future<String> getUserFieldWithId({String id, String field}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await databaseReference.collection('users').doc(id).get();

    if (!document.exists) {
      return null;
    } else {
      String str = document.get(field);
      return str;
    }
  } catch (e) {
    String str = 'Error: ' + e.toString();
    return str;
  }
}

Future<int> getBATotalNumber({String id}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await databaseReference.collection('users').doc(id).get();

    if (!document.exists) {
      return 0;
    } else {
      List count = document.get('bankAccount');
      int hola = count.length;
      return count.length;
    }
  } catch (e) {
    String str = 'Error: ' + e.toString();
    return -1;
  }
}

Future<DocumentSnapshot> getUser({String id}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await databaseReference.collection('users').doc(id).get();

    if (!document.exists) {
      return null;
    } else {
      return document;
    }
  } catch (e) {
    String str = 'Error: ' + e.toString();
    return null;
  }
}

// String textToString ({text}) {
//   String string;
//   string = text.data;
//   return string;
// }

Future<DocumentSnapshot> getFamily({String id}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await databaseReference.collection('families').doc(id).get();

    if (!document.exists) {
      return null;
    } else {
      return document;
    }
  } catch (e) {
    String str = 'Error: ' + e.toString();
    return null;
  }
}

Future<String> strGetFamily({String familyId}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await databaseReference.collection('families').doc(familyId).get();

    if (!document.exists) {
      return 'false';
    } else {
      return 'true';
    }
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}

Future<QuerySnapshot> searchFamily(
    {String name, String surnames}) async {
  try {
    name = name == null ? '' : name;
    surnames = surnames == null ? '' : surnames;
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    QuerySnapshot document = await databaseReference
        .collection('families')
        .where('familyName', isEqualTo: name)
        .where('surnames', isEqualTo: surnames)
        .get();

        return document;
    // if (document.docs.isNotEmpty) {
    //   return 'true';
    // } else {
    //   return 'false';
    // }
  } catch (e) {
    //return 'Error: ' + e.toString();
  }
}

// Future <List<String>> getFamilyArrayData({String familyId, String field}) async {
//   FirebaseFirestore.instance.collection("users").get().then((querySnapshot){
//       querySnapshot.docs.forEach((element){
//         element.data().;
//         List value = element.data["favourites"];
//         FirebaseFirestore.instance.collection("items").doc(value[0]).get().then((value){
//           print(value.data);
//         });
//       });
//     });

// }

Future<String> getFamilyArray({String familyId, String field}) async {
  await Firebase.initializeApp();
  CollectionReference users = FirebaseFirestore.instance.collection('families');

  FutureBuilder<DocumentSnapshot>(
      future: users.doc(familyId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Text('');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          //return str("${data[field]}");
          if (data != null) {
            return Text("${data[field]}");
          }
        }
        return Text("loading");
      });
}

// Future<String> getFamilyMember({String id}){
//   String member =
// }

Future<String> getTransaction(
    {String transactionId, String id, String type}) async {
  try {
    await Firebase.initializeApp();

    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document = await databaseReference
        .collection(type)
        .doc(id)
        .collection('transactions')
        .doc(transactionId)
        .get();

    if (!document.exists) {
      return 'false';
    } else {
      return 'true';
    }
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}

Future<String> getRecordatorio({String remindId, String id}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document = await databaseReference
        .collection('users')
        .doc(id)
        .collection('reminds')
        .doc(remindId)
        .get();

    if (!document.exists) {
      return 'false';
    } else {
      return 'true';
    }
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}

Future<String> getBankAccount({String baId, String id}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document = await databaseReference
        .collection('users')
        .doc(id)
        .collection('bankAccounts')
        .doc(baId)
        .get();

    if (!document.exists) {
      return 'false';
    } else {
      return 'true';
    }
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}

Future<String> checkIfExists({String collection, String userId, String documentId})  async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot document = await databaseReference
        .collection('users')
        .doc(userId)
        .collection(collection)
        .doc(documentId)
        .get();

    if (!document.exists) {
      return 'false';
    } else {
      return 'true';
    }
  } catch (e) {
    String id = 'Error: ' + e.toString();
    return id;
  }
}

class Prediction {
  final String prediction;

  Prediction({
    @required this.prediction
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    print(json['predictions']);
    return Prediction(
      prediction: json['predictions'].toString()
    );
  }
}

Future<Prediction> fetchPrediction() async {
  dynamic response =
      await http.get(Uri.parse('http://europe-west2-totemic-veld-318011.cloudfunctions.net/function-1'));
  int cont = 0;
  while (response.statusCode != 200 && cont < 3) {
    response =
      await http.get(Uri.parse('http://europe-west2-totemic-veld-318011.cloudfunctions.net/function-1'));
  }
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Prediction.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album. Error: ' + response.body);
  }
}


Future<String> aceptarSolicitud({String userIdRequest, String familyId}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    await databaseReference
        .collection('users')
        .doc(userIdRequest)
        .update({
          'FamilyId': familyId
        });
    
    await databaseReference
        .collection('families')
        .doc(familyId)
        .update({
          'members': FieldValue.arrayUnion([userIdRequest])
        });

    QuerySnapshot doc = await databaseReference
        .collection('families')
        .doc(familyId)
        .collection('requests')
        .where('userId', isEqualTo: userIdRequest)
        .get();
    
    await databaseReference
        .collection('families')
        .doc(familyId)
        .collection('requests')
        .doc(doc.docs.first.id)
        .delete();

    
    
    

    return 'true';
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}



Future<String> rechazarSolicitud({String userIdRequest, String familyId}) async {
  try {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    await databaseReference
        .collection('users')
        .doc(userIdRequest)
        .update({
          'FamilyId': ''
        });
    
    

    return 'true';
  } catch (e) {
    return 'Error: ' + e.toString();
  }
}
