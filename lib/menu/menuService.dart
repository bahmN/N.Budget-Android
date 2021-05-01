import 'dart:async';

import 'package:calendarro/date_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/menu/menuComponents.dart';
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

  Stream<double> readIncomeSum() {
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();

    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: _idUser)
        .where('dateIncome', isGreaterThanOrEqualTo: begMonth)
        .snapshots()
        .listen((event) {
      _streamC.add(
        event.docs.fold<double>(
          0.0,
          (previousValue, element) => previousValue + element.get('sumIncome'),
        ),
      );
    });
    return _streamC.stream;
  }

  Stream<double> readMandatoryCostsSum() {
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();
    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: 'Обязательные траты')
        .where('dateCosts', isGreaterThanOrEqualTo: begMonth)
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> readNotMandatoryCostsSum() {
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();
    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .where('category', isEqualTo: '')
        .where('dateCosts', isGreaterThanOrEqualTo: begMonth)
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> freeMoney() {
    return CombineLatestStream([readIncomeSum(), readMandatoryCostsSum()],
        (args) {
      return args[0] - args[1];
    });
  }

  Stream<double> remainderMoney() {
    return CombineLatestStream([freeMoney(), readNotMandatoryCostsSum()],
        (args) {
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

    //Today
    final DateTime toDay = DateTime.now();
    final DateFormat formatterDay = DateFormat.d();
    final String formattedDay = formatterDay.format(toDay);
    int toDayAsInt = int.parse(formattedDay);

    return remainderMoney()
        .map((event) => event / (lastDayOfMonthAsInt - toDayAsInt));
  }

  Stream<QuerySnapshot> readHistoryCostsStream() {
    return FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: _idUser)
        .snapshots();
  }

  Stream<QuerySnapshot> readHistoryIncomeStream() {
    return FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: _idUser)
        .snapshots();
  }

  Stream<List<FinanceItem>> get items {
    final costsStream = readHistoryCostsStream().map(
      (event) {
        return event.docs
            .map(
              (doc) => FinanceItem(
                title: doc['nameCosts'],
                sum: doc['sumCosts'],
                type: FinanceItemType.costs,
                date: doc['dateCosts'].toDate(),
                category: doc['category'],
              ),
            )
            .toList();
      },
    );

    final incomeStream = readHistoryIncomeStream().map(
      (event) {
        return event.docs
            .map(
              (doc) => FinanceItem(
                title: doc['nameIncome'],
                sum: doc['sumIncome'],
                type: FinanceItemType.income,
                date: doc['dateIncome'].toDate(),
              ),
            )
            .toList();
      },
    );

    return CombineLatestStream(
      [costsStream, incomeStream],
      (args) {
        final List combinedList = args[0] + args[1];
        combinedList.sort((lv, rv) => rv.date.compareTo(lv.date));
        return combinedList;
      },
    );
  }

  Stream<double> widthPB(totalWidth) {
    ServiceMenu _sMenu = ServiceMenu();
    return CombineLatestStream(
        [_sMenu.freeMoney(), _sMenu.readNotMandatoryCostsSum()], (args) {
      if (args[0] != 0.0 || args[1] != 0.0) {
        double percentMoney = ((args[0] - args[1]) / args[0]) *
            100; //(Остаток / свободные деньги) * 100
        if (percentMoney > 0) {
          //Width
          double _greenWidth = (totalWidth * percentMoney) / 100;
          return _greenWidth;
        } else {
          return 0.0;
        }
      } else {
        return 0.0;
      }
    });
  }
}
