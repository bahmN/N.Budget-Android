import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future writeData(
      String nameIncome, String comment, double sum, String idUser) async {
    await FirebaseFirestore.instance.collection('Income').add({
      'idUser': '$idUser',
      'nameIncome': '$nameIncome',
      'sumIncome': '$sum',
      'comment': '$comment'
    });
  }
}
