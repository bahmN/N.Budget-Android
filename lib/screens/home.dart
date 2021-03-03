import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/components/budgetInfoList.dart';
import 'package:nbudget/components/historyList.dart';
import 'package:nbudget/logic/moneyList.dart';
import 'package:nbudget/logic/date.dart';
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

  Widget _progressBar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4),
          height: 10,
          decoration: BoxDecoration(
            color: HexColor("#E5213E"),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
        LayoutBuilder(builder: (context, constrains) {
          return FutureBuilder<double>(
              future: widthPB(),
              builder: (context, snapshot) {
                return AnimatedContainer(
                  margin: EdgeInsets.only(top: 4),
                  width: snapshot.data,
                  height: 10,
                  duration: Duration(seconds: 3),
                  curve: Curves.ease,
                  constraints: constrains,
                  decoration: BoxDecoration(
                    color: HexColor("#51A34F"),
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                );
              });
        }),
      ],
    );
  }

  Widget _historyContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutCirc,
      width: 385,
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
          Expanded(
            child: HistoryList(),
          ),
          (_tapFullScreen == false
              ? IconButton(
                  icon: Icon(Icons.fullscreen_sharp),
                  onPressed: () {
                    setState(() {
                      if (_ifHistoryContainerTap == false) {
                        _tapFullScreen = true;
                        _ifHistoryContainerTap = true;
                        _topMarginHistoryContainer = 0;
                      } else {
                        _ifHistoryContainerTap = false;
                        _topMarginHistoryContainer = 285;
                      }
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.fullscreen_exit_sharp),
                  onPressed: () {
                    setState(() {
                      _tapFullScreen = false;
                      if (_ifHistoryContainerTap == false) {
                        _ifHistoryContainerTap = true;
                        _topMarginHistoryContainer = 0;
                      } else {
                        _ifHistoryContainerTap = false;
                        _topMarginHistoryContainer = 285;
                      }
                    });
                  },
                )),
        ],
      ),
    );
  }

  bool _tapFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F5F6'),
      appBar: AppBar(
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 110),
              child: Row(
                children: [
                  Text(
                    'N.Budget',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
      ),
      body: Container(
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Expanded(
                        child: FutureBuilder<double>(
                          future: remainderMoney(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                margin: EdgeInsets.only(left: 5),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${snapshot.data.toStringAsFixed(1)}₽',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
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
              child: InfoList(),
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
                            MaterialPageRoute(builder: (context) => Income()))
                        .then((value) => setState(() {}));
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
                    Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Costs()))
                        .then((value) => setState(() {}));
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
      ),
    );
  }
}
