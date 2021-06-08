import 'dart:async';

import 'package:calendarro/date_utils.dart' as dUtils;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/menu/menuComponents.dart';
import 'package:nbudget/menu/menuWidgets.dart';
import 'package:nbudget/r.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ServiceMenu {
  Future signOut() async {
    final FirebaseAuth _logOut = FirebaseAuth.instance;
    await _logOut.signOut();
  }

  Stream<double> readIncomeSum(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);
    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();

    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: user.id)
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

  Stream<double> readMandatoryCostsSum(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();
    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: user.id)
        .where('category', isEqualTo: 'Обязательные траты')
        .where('dateCosts', isGreaterThanOrEqualTo: begMonth)
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> readNotMandatoryCostsSum(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    // ignore: close_sinks
    StreamController<double> _streamC = StreamController.broadcast();
    DateTime date = DateTime.now();
    var begMonth = DateTime(date.year, date.month, 1);

    FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: user.id)
        .where('category', isEqualTo: '')
        .where('dateCosts', isGreaterThanOrEqualTo: begMonth)
        .snapshots()
        .listen((event) {
      _streamC.add(event.docs.fold<double>(0.0,
          (previousValue, element) => previousValue + element.get('sumCosts')));
    });
    return _streamC.stream;
  }

  Stream<double> freeMoney(BuildContext context) {
    return CombineLatestStream(
        [readIncomeSum(context), readMandatoryCostsSum(context)], (args) {
      return args[0] - args[1];
    });
  }

  Stream<double> remainderMoney(BuildContext context) {
    return CombineLatestStream(
        [freeMoney(context), readNotMandatoryCostsSum(context)], (args) {
      return args[0] - args[1];
    });
  }

  Stream<double> moneyPerDay(BuildContext context) {
    //Last day of month
    final DateTime nowYear = DateTime.now();
    final DateFormat formatterYear = DateFormat.y();
    final String formattedYear = formatterYear.format(nowYear);
    final DateTime nowMonth = DateTime.now();
    final DateFormat formatterMonth = DateFormat.M();
    final String formattedMonth = formatterMonth.format(nowMonth);
    DateTime lastDayOfMonth = dUtils.DateUtils.getLastDayOfMonth(
        DateTime(int.parse(formattedYear), int.parse(formattedMonth)));
    int lastDayOfMonthAsInt = lastDayOfMonth.day;

    //Today
    final DateTime toDay = DateTime.now();
    final DateFormat formatterDay = DateFormat.d();
    final String formattedDay = formatterDay.format(toDay);
    int toDayAsInt = int.parse(formattedDay);

    return remainderMoney(context).map((event) {
      int remainingDaysAsInt = lastDayOfMonthAsInt - toDayAsInt;
      if (remainingDaysAsInt > 0) {
        return event / (lastDayOfMonthAsInt - toDayAsInt);
      } else {
        return event;
      }
    });
  }

  Stream<QuerySnapshot> readHistoryCostsStream(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return FirebaseFirestore.instance
        .collection('Costs')
        .where('idUser', isEqualTo: user.id)
        .snapshots();
  }

  Stream<QuerySnapshot> readHistoryIncomeStream(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return FirebaseFirestore.instance
        .collection('Income')
        .where('idUser', isEqualTo: user.id)
        .snapshots();
  }

  Stream<List<FinanceItem>> items(BuildContext context) {
    final costsStream = readHistoryCostsStream(context).map(
      (event) {
        return event.docs
            .map(
              (doc) => FinanceItem(
                  title: doc['nameCosts'],
                  sum: doc['sumCosts'],
                  type: FinanceItemType.costs,
                  date: doc['dateCosts'].toDate(),
                  category: doc['category'],
                  id: doc.reference.id),
            )
            .toList();
      },
    );

    final incomeStream = readHistoryIncomeStream(context).map(
      (event) {
        return event.docs
            .map(
              (doc) => FinanceItem(
                  title: doc['nameIncome'],
                  sum: doc['sumIncome'],
                  type: FinanceItemType.income,
                  date: doc['dateIncome'].toDate(),
                  id: doc.reference.id),
            )
            .toList();
      },
    );

    if (selectedChoices == R.stringsOf(context).showOnlyCosts) {
      return costsStream;
    } else if (selectedChoices == R.stringsOf(context).showOnlyIncome) {
      return incomeStream;
    } else {
      return CombineLatestStream(
        [costsStream, incomeStream],
        (args) {
          final List combinedList = args[0] + args[1];
          combinedList.sort((lv, rv) => rv.date.compareTo(lv.date));
          return combinedList;
        },
      );
    }
  }

  Stream<double> widthPB(BuildContext context, totalWidth) {
    ServiceMenu _sMenu = ServiceMenu();
    return CombineLatestStream(
        [_sMenu.freeMoney(context), _sMenu.readNotMandatoryCostsSum(context)],
        (args) {
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

  Stream<String> nameMonth(BuildContext context) {
    //Month
    var nowDate = DateTime.now();
    var formatterDate = DateFormat.M();
    int monthInt = int.parse(formatterDate.format(nowDate));
    String monthStr;

    // ignore: close_sinks
    StreamController<String> controller;

    if (monthInt == 1) {
      monthStr = R.stringsOf(context).january;
    } else if (monthInt == 2) {
      monthStr = R.stringsOf(context).february;
    } else if (monthInt == 3) {
      monthStr = R.stringsOf(context).march;
    } else if (monthInt == 4) {
      monthStr = R.stringsOf(context).april;
    } else if (monthInt == 5) {
      monthStr = R.stringsOf(context).may;
    } else if (monthInt == 6) {
      monthStr = R.stringsOf(context).june;
    } else if (monthInt == 7) {
      monthStr = R.stringsOf(context).july;
    } else if (monthInt == 8) {
      monthStr = R.stringsOf(context).august;
    } else if (monthInt == 9) {
      monthStr = R.stringsOf(context).september;
    } else if (monthInt == 10) {
      monthStr = R.stringsOf(context).october;
    } else if (monthInt == 11) {
      monthStr = R.stringsOf(context).november;
    } else if (monthInt == 12) {
      monthStr = R.stringsOf(context).december;
    }

    controller = StreamController<String>(
      onListen: () {
        controller.add(monthStr);
      },
    );
    return controller.stream;
  }
}
