double percentMoney;

double widthPB() {
  //Money
  double _fMoney = 9657; //Всего свободных денег
  double _spentMoney = 5590.68; //Потрачено
  double _fMoneyRemains = _fMoney - _spentMoney; //Остаток
  percentMoney =
      double.parse(((_fMoneyRemains / _fMoney) * 100).toStringAsFixed(2));

  //Width
  double _totalWidth = 365;
  double _greenWidth =
      double.parse(((_totalWidth * percentMoney) / 100).toStringAsFixed(2));
  return _greenWidth;
}
