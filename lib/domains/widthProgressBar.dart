import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

double widthPB() {
  //Money
  double _fMoney = 9657; //Всего свободных денег
  double _spentMoney = 5590.68; //Потрачено
  double _fMoneyRemains = _fMoney - _spentMoney; //Остаток
  double _percentMoney =
      double.parse(((_fMoneyRemains / _fMoney) * 100).toStringAsFixed(2));
  print(_percentMoney);

  //Width
  double _totalWidth = 365;
  double _greenWidth =
      double.parse(((_totalWidth * _percentMoney) / 100).toStringAsFixed(2));
  print(_greenWidth);
  return _greenWidth;
}

class ProgressBar extends StatefulWidget {
  ProgressBar({Key key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 365,
          height: 10,
          decoration: BoxDecoration(
            color: HexColor("#E5213E"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
        AnimatedContainer(
          margin: EdgeInsets.only(top: 4),
          width: widthPB(),
          height: 10,
          duration: Duration(seconds: 3),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: HexColor("#51A34F"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
      ],
    );
  }
}
