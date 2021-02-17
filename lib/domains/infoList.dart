import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Info {
  double income;
  double mExpenses;
  double fMoney;
  double moneyDay;

  Info({this.income, this.mExpenses, this.fMoney, this.moneyDay}) {
    //Day
    DateTime today = DateTime.now();
    DateFormat dayFormatter = DateFormat('M');
    String sDay = dayFormatter.format(today);
    int iDay = int.parse(sDay);

    //Year
    DateTime todayY = DateTime.now();
    DateFormat dayFormatterY = DateFormat('y');
    String sDayY = dayFormatterY.format(todayY);
    int iDayY = int.parse(sDayY);

    //Days in month
    var dateUtility = DateUtil();
    var dayInMonth = dateUtility.daysInMonth(iDay, iDayY);

    fMoney = income - mExpenses;
    moneyDay = fMoney / dayInMonth;
    moneyDay = double.parse(moneyDay.toStringAsFixed(2));
  }
}

class InfoList extends StatelessWidget {
  final infoList = <Info>[
    Info(income: 15225, mExpenses: 5568),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Income
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 191, bottom: 10),
              child: Text(
                'Доход',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 120,
              alignment: Alignment.centerRight,
              child: Text(
                '${infoList[0].income}₽',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        //mExpenses
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 51, bottom: 8),
              child: Text(
                'Обязтельные расходы',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 120,
              alignment: Alignment.centerRight,
              child: Text(
                '${infoList[0].mExpenses}₽',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        //FreeMoney
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 94, bottom: 8),
              child: Text(
                'Свободных денег',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 120,
              alignment: Alignment.centerRight,
              child: Text(
                '${infoList[0].fMoney}₽',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        //Money in the day
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 104, bottom: 8),
              child: Text(
                'Бюджет на день',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 120,
              alignment: Alignment.centerRight,
              child: Text(
                '${infoList[0].moneyDay}₽',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
