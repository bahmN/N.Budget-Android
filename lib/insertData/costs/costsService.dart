import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CostsService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> writeCosts(String nameIncome, String comment, double sum,
      String category, DateTime date) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    try {
      await FirebaseFirestore.instance.collection('Costs').add(
        {
          'idUser': _idUser,
          'nameCosts': nameIncome,
          'sumCosts': sum,
          'commentCosts': comment,
          'category': category,
          'dateCosts': date
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
