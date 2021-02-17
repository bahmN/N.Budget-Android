import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

double widthPB() {
  //Money
  double _fMoney = 9657;
  double _spentMoney = 4828.5;
  double _percentMoney =
      double.parse(((_spentMoney / _fMoney) * 100).toStringAsFixed(2));
  print(_percentMoney);

  //Width
  double _redWidth = 365;
  double _greenWidth =
      double.parse(((_redWidth * _percentMoney) / 100).toStringAsFixed(2));
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
        Container(
          margin: EdgeInsets.only(top: 4),
          width: widthPB(),
          height: 10,
          decoration: BoxDecoration(
            color: HexColor("#51A34F"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
      ],
    );
  }
}
