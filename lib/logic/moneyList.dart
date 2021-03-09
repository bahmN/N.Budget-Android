import 'package:nbudget/logic/date.dart';
import 'package:nbudget/logic/services/database.dart';
import 'package:rxdart/rxdart.dart';

Stream<double> remainderMoney() {
  return CombineLatestStream([freeMoney(), readNotRequiredCosts()], (args) {
    return args[0] - args[1];
  });
}

Stream<double> moneyADay() {
  return remainderMoney().map((event) => event / lastDayOfMonth());
}

Stream<double> freeMoney() {
  return CombineLatestStream([readIncome(), readRequiredCosts()], (args) {
    return args[0] - args[1];
  });
}
