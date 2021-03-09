import 'package:nbudget/logic/moneyList.dart';
import 'package:nbudget/logic/services/database.dart';

Stream<double> widthPB() {
  return freeMoney().asyncMap((event) async {
    double percentMoney;

    //Money
    double _spentMoney = await readNotRequiredCosts(); //Потрачено
    double _fMoneyRemains = event - _spentMoney; //Остаток
    percentMoney = (_fMoneyRemains / event) * 100;

    //Width
    double _totalWidth = 365;
    double _greenWidth = (_totalWidth * percentMoney) / 100;
    return _greenWidth;
  });
}
