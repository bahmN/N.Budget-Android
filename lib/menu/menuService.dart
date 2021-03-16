import 'dart:async';

import 'package:calendarro/date_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

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
    // ignore: close_sinks
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

  Stream<double> readMandatoryCosts() {
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: 'Обязательные траты')
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> readNotMandatoryCosts() {
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: '')
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> freeMoney() {
    return CombineLatestStream([readIncome(), readMandatoryCosts()], (args) {
      return args[0] - args[1];
    });
  }

  Stream<double> remainderMoney() {
    return CombineLatestStream([freeMoney(), readNotMandatoryCosts()], (args) {
      return args[0] - args[1];
    });
  }

  Stream<double> moneyPerDay() {
    //Last day of month
    final DateTime nowYear = DateTime.now();
    final DateFormat formatterYear = DateFormat.y();
    final String formattedYear = formatterYear.format(nowYear);
    final DateTime nowMonth = DateTime.now();
    final DateFormat formatterMonth = DateFormat.M();
    final String formattedMonth = formatterMonth.format(nowMonth);
    DateTime lastDayOfMonth = DateUtils.getLastDayOfMonth(
        DateTime(int.parse(formattedYear), int.parse(formattedMonth)));
    int lastDayOfMonthAsInt = lastDayOfMonth.day;

    return remainderMoney().map((event) => event / lastDayOfMonthAsInt);
  }
}
