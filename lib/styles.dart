import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/*
  Light theme
*/
final lightTheme = ThemeData.light().copyWith(
  primaryColor: HexColor('#FFE60D'),
  primaryColorLight: HexColor('#FFFFFF'),
  backgroundColor: HexColor('#F5F5F6'),
  shadowColor: HexColor("#000000").withOpacity(0.35),
  appBarTheme: AppBarTheme(color: HexColor('#FFE60D')),
);

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
