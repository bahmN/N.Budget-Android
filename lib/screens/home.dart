import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/components/budgetInfoList.dart';
import 'package:nbudget/logic/nowMonth.dart';
import 'package:nbudget/logic/services/auth.dart';
import 'package:nbudget/logic/widthProgressBar.dart';
import 'package:nbudget/screens/addIncome.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Widget progressBar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 365,
          height: 10,
          decoration: BoxDecoration(
            color: HexColor("#E5213E"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
        AnimatedContainer(
          margin: EdgeInsets.only(top: 4),
          width: widthPB(),
          height: 10,
          duration: Duration(seconds: 3),
          curve: Curves.ease,
          decoration: BoxDecoration(
            color: HexColor("#51A34F"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 150),
              child: Row(
                children: [
                  Text(
                    'Баланс:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService().signOut();
            },
          ),
        ],
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
                  progressBar(),
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
              child: InfoList(13658.0, 5568.0),
            ),
            //2 button's "add"
            Row(children: [
              Container(
                width: 190,
                height: 36,
                margin: EdgeInsets.only(bottom: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: HexColor("#000000").withOpacity(0.35),
                          offset: Offset(1, 4))
                    ]),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddIC()));
                  },
                  color: HexColor('#FFE60D'),
                  child: Text(
                    'Добавить доход',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 190,
                height: 36,
                margin: EdgeInsets.only(bottom: 19),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(1, 4))
                  ],
                ),
                child: RaisedButton(
                  onPressed: () {},
                  color: HexColor('#FFE60D'),
                  child: Text(
                    'Добавить расходы',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
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
