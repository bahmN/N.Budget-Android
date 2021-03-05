import 'package:nbudget/logic/date.dart';
import 'package:nbudget/logic/services/database.dart';

Future<double> remainderMoney() async {
  double remainderMoney = await readIncome() - await readCosts();
  return remainderMoney;
}

Future<String> moneyADay() async {
  double moneyOfDay = await remainderMoney() / lastDayOfMonth();
  return moneyOfDay.toStringAsFixed(1);
}

Future<double> freeMoney() async {
  double freeMoney = await readIncome() - await readRequiredCosts();
  return freeMoney;
}
