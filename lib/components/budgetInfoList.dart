import 'package:flutter/material.dart';
import 'package:nbudget/logic/infoList.dart';

class InfoList extends StatelessWidget {
  var infoList;
  double incomeIL;
  double mExpensesIL;

  InfoList(incomeIL, mExpensesIL) {
    infoList = <Info>[
      Info(income: incomeIL, mExpenses: mExpensesIL),
    ];
  }

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
