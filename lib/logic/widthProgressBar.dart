import 'package:nbudget/logic/moneyList.dart';
import 'package:nbudget/logic/services/database.dart';

Future<double> widthPB() async {
  double percentMoney;

  //Money
  double _fMoney = await freeMoney(); //Всего свободных денег
  double _spentMoney = await readNotRequiredCosts(); //Потрачено
  double _fMoneyRemains = _fMoney - _spentMoney; //Остаток
  percentMoney = (_fMoneyRemains / _fMoney) * 100;

  //Width
  double _totalWidth = 365;
  double _greenWidth = (_totalWidth * percentMoney) / 100;
  return _greenWidth;
}
