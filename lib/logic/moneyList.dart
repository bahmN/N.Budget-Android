import 'package:nbudget/logic/date.dart';
import 'package:nbudget/logic/services/database.dart';

Stream<double> remainderMoney() {
  return freeMoney()
      .asyncMap((event) async => event - await readNotRequiredCosts());
}

Stream<double> moneyADay() {
  return remainderMoney().map((event) => event / lastDayOfMonth());
}

Stream<double> freeMoney() {
  return readIncome().map((event) => event - readRequiredCosts());
}
