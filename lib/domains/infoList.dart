import 'package:date_util/date_util.dart';
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
    moneyDay = double.parse((fMoney / dayInMonth).toStringAsFixed(2));
  }
}
