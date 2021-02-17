import 'package:intl/intl.dart';

String nowMonth() {
  final DateTime nowMonth = DateTime.now();
  final DateFormat formatterMonth = DateFormat('MMMM');
  final String formattedMonth = formatterMonth.format(nowMonth);
  return "До конца $formattedMonth осталось";
}
