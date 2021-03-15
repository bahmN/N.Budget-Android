import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IncomeService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> writeIncome(
      String nameIncome, String comment, double sum, DateTime date) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    try {
      await FirebaseFirestore.instance.collection('Income').add(
        {
          'idUser': _idUser,
          'nameIncome': nameIncome,
          'sumIncome': sum,
          'commentIncome': comment,
          'dateIncome': date
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
