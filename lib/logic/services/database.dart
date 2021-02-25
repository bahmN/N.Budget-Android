import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future writeIncome(
      String nameIncome, String comment, double sum, String idUser) async {
    await FirebaseFirestore.instance.collection('Income').add({
      'idUser': '$idUser',
      'nameIncome': '$nameIncome',
      'sumIncome': '$sum',
      'commentIncome': '$comment'
    });
  }

  Future writeCosts(
      String nameIncome, String comment, double sum, String idUser) async {
    await FirebaseFirestore.instance.collection('Costs').add({
      'idUser': '$idUser',
      'nameCosts': '$nameIncome',
      'sumCosts': '$sum',
      'commentCosts': '$comment'
    });
  }
}
