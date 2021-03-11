import 'package:flutter/widgets.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class MenuWidgets {
  Widget progressBlockMenu(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(bottom: 20),
      decoration: borderShadowsLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                R.stringsOf(context).balanceMonthFirstBlock,
                style: txtHeader,
              ),
              Expanded(
                child: StreamBuilder<double>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '1000000000',
                        style: txtBalance,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoBlocMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: borderShadowsLight,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).income,
                  style: txtHeader,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '1000000',
                      style: txtBalance,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).mandatoryExpenses,
                  style: txtHeader,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '1000000',
                      style: txtBalance,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).freeMoney,
                  style: txtHeader,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '1000000',
                      style: txtBalance,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                R.stringsOf(context).dailyBudget,
                style: txtHeader,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '1000000',
                    style: txtBalance,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
