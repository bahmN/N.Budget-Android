import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
  Future writeIncome(String nameIncome, String comment, double sum) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    await FirebaseFirestore.instance.collection('Income').add({
      'idUser': '$_idUser',
      'nameIncome': '$nameIncome',
      'sumIncome': sum,
      'commentIncome': '$comment'
    });
  }

  Future writeCosts(String nameIncome, String comment, double sum) async {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;
    await FirebaseFirestore.instance.collection('Costs').add({
      'idUser': '$_idUser',
      'nameCosts': '$nameIncome',
      'sumCosts': sum,
      'commentCosts': '$comment'
    });
  }
}

Future readCosts() async {
  try {
    final User _user = auth.currentUser;
    final _idUser = _user.uid;

    final _costs = await FirebaseFirestore.instance
        .collection('Costs')
        .where('_idUser', isEqualTo: _idUser)
        .get();
    return _costs.docs.fold<double>(0.0,
        (previousValue, element) => previousValue + element.get('sumCosts'));
  } catch (e) {
    print(e);
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
    print(e);
  }
}
