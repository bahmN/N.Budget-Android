import 'package:intl/intl.dart';

//For budget list
String nowMonthList() {
  final DateTime nowMonth = DateTime.now();
  final DateFormat formatterMonth = DateFormat('MMMM');
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
