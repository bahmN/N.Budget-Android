import 'package:nbudget/logic/services/database.dart';

Future<double> widthPB() async {
  double percentMoney;

  //Money
  double _fMoney = await readIncome(); //Всего свободных денег
  double _spentMoney = await readCosts(); //Потрачено
  double _fMoneyRemains = _fMoney - _spentMoney; //Остаток
  percentMoney =
      double.parse(((_fMoneyRemains / _fMoney) * 100).toStringAsFixed(2));

  //Width
  double _totalWidth = 365;
  double _greenWidth =
      double.parse(((_totalWidth * percentMoney) / 100).toStringAsFixed(2));
  return _greenWidth;
}
