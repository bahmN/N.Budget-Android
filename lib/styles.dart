import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/*
  Light theme
*/
final lightTheme = ThemeData.light().copyWith(
  primaryColor: HexColor('#FFE60D'),
  primaryColorLight: HexColor('#FFFFFF'),
  primaryColorDark: HexColor("#000000"),
  backgroundColor: HexColor('#F5F5F6'),
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

/*
  Menu txt style
*/
final txtHeader = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final txtBalance = TextStyle(fontSize: 20, fontWeight: FontWeight.w300);

/*
  Auth txt styles
*/
final txtInput = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w300, color: HexColor('#000000'));
final txtHintInput = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w300, color: HexColor('#A7A7A7'));
final bttnAuth = TextStyle(fontSize: 25, fontWeight: FontWeight.w300);
final bottomBttn = TextStyle(
    color: HexColor('#A7A7A7'), fontSize: 15, fontWeight: FontWeight.w200);
final labelAuth = TextStyle(fontSize: 30, fontWeight: FontWeight.w200);

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
