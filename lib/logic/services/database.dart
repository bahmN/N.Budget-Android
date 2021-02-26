import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
  Future writeIncome(String nameIncome, String comment, double sum) async {
    final User user = auth.currentUser;
    final idUser = user.uid;
    await FirebaseFirestore.instance.collection('Income').add({
      'idUser': '$idUser',
      'nameIncome': '$nameIncome',
      'sumIncome': '$sum',
      'commentIncome': '$comment'
    });
  }

  Future writeCosts(String nameIncome, String comment, double sum) async {
    final User user = auth.currentUser;
    final idUser = user.uid;
    await FirebaseFirestore.instance.collection('Costs').add({
      'idUser': '$idUser',
      'nameCosts': '$nameIncome',
      'sumCosts': '$sum',
      'commentCosts': '$comment'
    });
  }
}
