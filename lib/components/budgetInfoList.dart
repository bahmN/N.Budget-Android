import 'package:flutter/material.dart';
import 'package:nbudget/logic/moneyList.dart';
import 'package:nbudget/logic/services/database.dart';

class InfoList extends StatelessWidget {
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
              child: FutureBuilder<double>(
                  future: readIncome(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data.toStringAsFixed(1)}₽',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      );
                    } else {
                      return Text(
                        '0₽',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      );
                    }
                  }),
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
              child: FutureBuilder<double>(
                  future: readRequiredCosts(),
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data.toStringAsFixed(1)}₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  }),
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
            FutureBuilder<double>(
                future: freeMoney(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: 120,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${snapshot.data}₽',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 120,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '0₽',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  }
                })
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
            FutureBuilder<String>(
              future: moneyADay(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 120,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${snapshot.data}₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 120,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '0₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
