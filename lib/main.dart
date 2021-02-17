import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/screens/menu.dart';

void main() => runApp(NBudget());

class NBudget extends StatelessWidget {
  const NBudget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NBudget',
        theme: ThemeData(primaryColor: HexColor('#FFE60D')),
        home: MenuPage());
  }
}
