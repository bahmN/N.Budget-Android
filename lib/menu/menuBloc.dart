import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbudget/insertData/costs/costsScreen.dart';
import 'package:nbudget/insertData/income/incomeScreen.dart';
import 'package:nbudget/menu/menuComponents.dart';

class MenuMethods {
  void navIncomScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IncomeScreen()));
  }

  void navCostsScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CostsScreen()));
  }

  Future deleteHistory(
      AsyncSnapshot<List<FinanceItem>> snapshot, int index) async {
    await FirebaseFirestore.instance
        .collection(snapshot.data[index].type == FinanceItemType.income
            ? 'Income'
            : 'Costs')
        .doc(snapshot.data[index].id)
        .delete();
  }
}
