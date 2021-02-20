import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/domains/infoList.dart';
import 'package:nbudget/domains/nowMonth.dart';
import 'package:nbudget/domains/widthProgressBar.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('N.Budget'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        color: HexColor('#F5F5F6'),
        child: Column(
          children: [
            //Container for block remainder
            Container(
              width: 385,
              height: 45,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(4, 4))
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          nowMonth(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 120,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ProgressBar(),
                ],
              ),
            ),
            //Container for block info
            Container(
              width: 385,
              height: 128,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(4, 4))
                  ]),
              child: InfoList(),
            ),
            //2 button's "add"
            Row(children: [
              Container(
                width: 190,
                height: 36,
                margin: EdgeInsets.only(bottom: 20, right: 5),
                decoration: BoxDecoration(
                    color: HexColor('#FFE60D'),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: HexColor("#000000").withOpacity(0.35),
                          offset: Offset(1, 4))
                    ]),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Добавить доход',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 190,
                height: 36,
                margin: EdgeInsets.only(bottom: 19),
                decoration: BoxDecoration(
                    color: HexColor('#FFE60D'),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: HexColor("#000000").withOpacity(0.35),
                          offset: Offset(1, 4))
                    ]),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Добавить траты',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            //Container for block history
            Container(
              width: 385,
              height: 440,
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(4, 4))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
