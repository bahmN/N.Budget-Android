import 'package:nbudget/logic/moneyList.dart';
import 'package:nbudget/logic/services/database.dart';
import 'package:rxdart/streams.dart';

Stream<double> widthPB() {
  return CombineLatestStream([freeMoney(), readNotRequiredCosts()], (args) {
    double percentMoney;
    double _spentMoney = args[1]; //Потрачено
    double _fMoneyRemains = args[0] - _spentMoney; //Остаток
    percentMoney = (_fMoneyRemains / args[0]) * 100;

    //Width
    double _totalWidth = 365;
    double _greenWidth = (_totalWidth * percentMoney) / 100;
    return _greenWidth;
  });
}
