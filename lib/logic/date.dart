import 'package:calendarro/date_utils.dart';
import 'package:intl/intl.dart';

//For budget list
String nowMonthList() {
  final DateTime nowMonth = DateTime.now();
  final DateFormat formatterMonth = DateFormat.MMMM('ru');
  final String formattedMonth = formatterMonth.format(nowMonth);
  return "До конца $formattedMonth осталось";
}

//For income calendar
String dateCalendar() {
  final DateTime nowDate = DateTime.now();
  final DateFormat formatterDate = DateFormat('d.MM.y');
  final String formattedDate = formatterDate.format(nowDate);
  return "$formattedDate";
}

int lastDayOfMonth() {
  final DateTime nowYear = DateTime.now();
  final DateFormat formatterYear = DateFormat.y();
  final String formattedYear = formatterYear.format(nowYear);

  final DateTime nowMonth = DateTime.now();
  final DateFormat formatterMonth = DateFormat.M();
  final String formattedMonth = formatterMonth.format(nowMonth);

  DateTime lastDayOfMonth = DateUtils.getLastDayOfMonth(
      DateTime(int.parse(formattedYear), int.parse(formattedMonth)));
  int lastDayOfMonthAsInt = lastDayOfMonth.day;
  return lastDayOfMonthAsInt;
}
