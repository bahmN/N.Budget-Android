import 'package:nbudget/logic/date.dart';
import 'package:nbudget/logic/services/database.dart';

Future<double> remainderMoney() async {
  double freeMoney = await readIncome() - await readCosts();
  return freeMoney;
}

Future<String> moneyADay() async {
  double moneyOfDay = await remainderMoney() / lastDayOfMonth();
  return moneyOfDay.toStringAsFixed(1);
}
