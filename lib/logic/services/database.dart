import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
  Future writeIncome(
      String nameIncome, String comment, double sum, DateTime date) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    await FirebaseFirestore.instance.collection('Income').add({
      'idUser': _idUser,
      'nameIncome': nameIncome,
      'sumIncome': sum,
      'commentIncome': comment,
      'dateIncome': date
    });
  }

  Future writeCosts(String nameIncome, String comment, double sum,
      String category, DateTime date) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    await FirebaseFirestore.instance.collection('Costs').add({
      'idUser': _idUser,
      'nameCosts': nameIncome,
      'sumCosts': sum,
      'commentCosts': comment,
      'category': category,
      'dateCosts': date
    });
  }
}

Future<double> readCosts() async {
  try {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;

    final _costs = await FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .get();
    return _costs.docs.fold<double>(0.0,
        (previousValue, element) => previousValue + element.get('sumCosts'));
  } catch (e) {
    return 0.0;
  }
}

Future<double> readIncome() async {
  try {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;

    final _income = await FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: _idUser)
        .get();
    return _income.docs.fold<double>(0.0,
        (previousValue, element) => previousValue + element.get('sumIncome'));
  } catch (e) {
    return 0.0;
  }
}

Future<double> readRequiredCosts() async {
  try {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;

    final _reqCosts = await FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: 'Обязательные траты')
        .get();
    return _reqCosts.docs.fold<double>(0.0,
        (previousValue, element) => previousValue + element.get('sumCosts'));
  } catch (e) {
    return 0.0;
  }
}

Future<double> readNotRequiredCosts() async {
  try {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    final _costs = await FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: '')
        .get();
    return _costs.docs.fold<double>(0.0,
        (previousValue, element) => previousValue + element.get('sumCosts'));
  } catch (e) {
    return 0.0;
  }
}

Stream<QuerySnapshot> readHistoryStream() {
  final User _user = auth.currentUser;
  final _idUser = _user.uid;
  return FirebaseFirestore.instance
      .collection('Costs')
      .where('idUser', isEqualTo: _idUser)
      .snapshots();
}
