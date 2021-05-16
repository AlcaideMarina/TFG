import 'package:firebase_auth/firebase_auth.dart';


Future<void> register(String mail, String pw) {

}

Future<bool> logIn(String mail, String pw) async {
  try {
    await FirebaseAuth
      .instance
      .createUserWithEmailAndPassword(email: mail, password: pw);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
