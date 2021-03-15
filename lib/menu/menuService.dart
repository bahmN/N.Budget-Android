import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ID user for read data
final FirebaseAuth _auth = FirebaseAuth.instance;
final User _user = _auth.currentUser;
final _idUser = _user.uid;

class ServiceMenu {
  Future signOut() async {
    final FirebaseAuth _logOut = FirebaseAuth.instance;
    await _logOut.signOut();
  }

  Stream<double> readIncome() {
    StreamController<double> _streamC = StreamController.broadcast();

    FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: _idUser)
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(
          0.0,
          (previousValue, element) =>
              previousValue + element.get('sumIncome')));
    });
    return _streamC.stream;
  }
}
