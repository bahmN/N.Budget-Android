import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/components/budgetInfoList.dart';
import 'package:nbudget/logic/nowDate.dart';
import 'package:nbudget/logic/services/auth.dart';
import 'package:nbudget/logic/widthProgressBar.dart';
import 'package:nbudget/screens/addCosts.dart';
import 'package:nbudget/screens/addIncome.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _ifHistoryContainerTap = false;
  double _topMarginHistoryContainer = 285;
  double _heightHistoryContainer = 450;

  Widget _progressBar() {
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

  Widget _historyContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutCirc,
      width: 385,
      height: _heightHistoryContainer,
      margin: EdgeInsets.only(top: _topMarginHistoryContainer),
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
          Container(
            width: 385,
            height: 35,
            decoration: BoxDecoration(
              color: HexColor('#FFE60D'),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0)),
            ),
            child: Center(
              child: Text(
                'История',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.fullscreen_sharp),
                onPressed: () {
                  setState(() {
                    if (_ifHistoryContainerTap == false) {
                      _ifHistoryContainerTap = true;
                      _topMarginHistoryContainer = 0;
                      _heightHistoryContainer = 750;
                    } else {
                      _ifHistoryContainerTap = false;
                      _topMarginHistoryContainer = 285;
                      _heightHistoryContainer = 450;
                    }
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F5F6'),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Income').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
            child: Stack(
              children: [
                //Container for block remainder
                Container(
                  width: 385,
                  height: 45,
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
                              nowMonthList(),
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
                      _progressBar(),
                    ],
                  ),
                ),
                //Container for block info
                Container(
                  width: 385,
                  height: 128,
                  margin: EdgeInsets.only(top: 65),
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
                    margin: EdgeInsets.only(top: 220, right: 5),
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
                            MaterialPageRoute(builder: (context) => Income()));
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
                    margin: EdgeInsets.only(top: 220),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: HexColor("#000000").withOpacity(0.35),
                            offset: Offset(1, 4))
                      ],
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Costs()),
                        );
                      },
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
                _historyContainer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
