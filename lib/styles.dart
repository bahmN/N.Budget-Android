import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:hexcolor/hexcolor.dart';

/*
  Light theme
*/
final lightTheme = ThemeData.light().copyWith(
  primaryColor: HexColor('#FFE60D'),
  primaryColorLight: HexColor('#FFFFFF'),
  primaryColorDark: HexColor("#000000"),
  backgroundColor: HexColor('#F5F5F6'),
  accentColor: HexColor('#A7A7A7'),
  shadowColor: HexColor("#000000").withOpacity(0.35),
  appBarTheme: AppBarTheme(
    color: HexColor('#FFE60D'),
    actionsIconTheme: IconThemeData(color: HexColor("#000000")),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: HexColor('#000000'),
      ),
    ),
  ),
  errorColor: HexColor('#E5213E'),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) => HexColor('#000000'),
      ),
      textStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => HexColor('#FFE60D'),
      ),
    ),
  ),
);

final txtHeader = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final txtNormal = TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
final txtSymbol = TextStyle(
    color: HexColor('#000000'), fontSize: 40, fontWeight: FontWeight.w300);
final txtInsert = TextStyle(
    fontSize: 40, fontWeight: FontWeight.w200, color: HexColor('#A7A7A7'));
final hintTxtSum = TextStyle(
    fontSize: 40, fontWeight: FontWeight.w200, color: HexColor('#A7A7A7'));
final hintTxt = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w200, color: HexColor('#A7A7A7'));

final txtInput = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w300, color: HexColor('#000000'));
final txtHintInput = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w300, color: HexColor('#A7A7A7'));
final bttnAuth = TextStyle(fontSize: 25, fontWeight: FontWeight.w300);
final bottomBttn = TextStyle(
    color: HexColor('#A7A7A7'), fontSize: 15, fontWeight: FontWeight.w200);
final labelAuth = TextStyle(fontSize: 30, fontWeight: FontWeight.w200);
final filterChipTxt = TextStyle(fontSize: 17, fontWeight: FontWeight.w300);
final dateTxt = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w200, color: HexColor('#A7A7A7'));
final nameHistoryTxt = TextStyle(
    color: HexColor('#A7A7A7'), fontSize: 17, fontWeight: FontWeight.w300);
final sumHistoryTxt = TextStyle(fontSize: 20, fontWeight: FontWeight.w300);

/*
  BorderShadows
*/
final borderShadowsLight = BoxDecoration(
  color: HexColor('#FFFFFF'),
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
  boxShadow: [
    BoxShadow(
      blurRadius: 3,
      color: HexColor("#000000").withOpacity(0.35),
      offset: Offset(4, 4),
    )
  ],
);

/*
  Don't shadows
*/
final borderDontShadowsLight = BoxDecoration(
  color: HexColor('#FFE60D'),
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

/*
  Don't shadows (red)
*/
final borderDontShadowsLightRed = BoxDecoration(
  color: HexColor('#E5213E'),
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);
/*
  Don't shadows (Green)
*/
final borderDontShadowsLightGreen = BoxDecoration(
  color: HexColor('#51A34F'),
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

/*
    DateTimePicker
 */
MaterialRoundedDatePickerStyle datePickerStyle(BuildContext context) {
  return MaterialRoundedDatePickerStyle(
    textStyleButtonPositive:
        TextStyle(color: Theme.of(context).primaryColorDark),
    textStyleButtonNegative:
        TextStyle(color: Theme.of(context).primaryColorDark),
    textStyleDayButton: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    paddingMonthHeader: EdgeInsets.all(13),
    textStyleDayHeader: TextStyle(fontSize: 17),
    textStyleCurrentDayOnCalendar: TextStyle(
        color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
    textStyleDayOnCalendarSelected:
        TextStyle(color: Theme.of(context).primaryColorDark),
    decorationDateSelected: BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: BoxShape.circle,
    ),
  );
}
