import 'package:firebase_auth/firebase_auth.dart';

class ServiceMenu {
  Future signOut() async {
    final FirebaseAuth _logOut = FirebaseAuth.instance;
    await _logOut.signOut();
  }
}
