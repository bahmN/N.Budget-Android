import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbudget/screensInsertData/costs/incomeScreen.dart';
import 'package:nbudget/screensInsertData/income/incomeScreen.dart';

void navIncomScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => IncomeScreen()));
}

void navCostsScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CostsScreen()));
}
