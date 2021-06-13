import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IncomeService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> writeIncome(
    String id,
    String nameIncome,
    String comment,
    double sum,
    DateTime date,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('Income').add({
        'idUser': id,
        'nameIncome': nameIncome,
        'sumIncome': sum,
        'commentIncome': comment,
        'dateIncome': date
      });
    } catch (e) {
      print(e);
    }
  }
}
