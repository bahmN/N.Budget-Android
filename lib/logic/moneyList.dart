import 'package:nbudget/logic/date.dart';
import 'package:nbudget/logic/services/database.dart';

Future<double> remainderMoney() async {
  double remainderMoney = await freeMoney() - await readNotRequiredCosts();
  return remainderMoney;
}

Future<double> moneyADay() async {
  double moneyOfDay = await remainderMoney() / lastDayOfMonth();
  return moneyOfDay;
}

Future<double> freeMoney() async {
  double freeMoney = await readIncome() - await readRequiredCosts();
  return freeMoney;
}
