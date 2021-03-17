import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbudget/menu/menuComponents.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class MenuWidgets {
  ServiceMenu _sMenu = ServiceMenu();

  Widget progressBlockMenu(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(bottom: 20),
      decoration: borderShadowsLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                R.stringsOf(context).balanceMonthFirstBlock,
                style: txtHeader,
              ),
              Expanded(
                child: StreamBuilder<double>(
                  stream: _sMenu.remainderMoney(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          R.stringsOf(context).zeroMoney +
                              R.stringsOf(context).symbolMoney,
                          style: txtNormal,
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${snapshot.data}' + R.stringsOf(context).symbolMoney,
                          style: txtNormal,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoContainerMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 11),
      decoration: borderShadowsLight,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).incomeI,
                  style: txtHeader,
                ),
                Expanded(
                  child: StreamBuilder<double>(
                    stream: _sMenu.readIncome(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            R.stringsOf(context).zeroMoney +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${snapshot.data}' +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).mandatoryExpenses,
                  style: txtHeader,
                ),
                Expanded(
                  child: StreamBuilder<double>(
                    stream: _sMenu.readMandatoryCosts(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            R.stringsOf(context).zeroMoney +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${snapshot.data}' +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  R.stringsOf(context).freeMoney,
                  style: txtHeader,
                ),
                Expanded(
                  child: StreamBuilder<double>(
                    stream: _sMenu.freeMoney(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            R.stringsOf(context).zeroMoney +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${snapshot.data}' +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(
                R.stringsOf(context).dailyBudget,
                style: txtHeader,
              ),
              Expanded(
                child: StreamBuilder<double>(
                  stream: _sMenu.moneyPerDay(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          R.stringsOf(context).zeroMoney +
                              R.stringsOf(context).symbolMoney,
                          style: txtNormal,
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${snapshot.data.toStringAsFixed(2)}' +
                              R.stringsOf(context).symbolMoney,
                          style: txtNormal,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String label, void func()) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: ElevatedButton(
        onPressed: func,
        child: Text(
          label,
        ),
      ),
    );
  }
}

class HistoryWidget extends StatefulWidget {
  HistoryWidget({Key key}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.8),
      curve: Curves.easeOutCirc,
      width: double.infinity,
      height: 300,
      decoration: borderShadowsLight,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 20,
            decoration: borderDontShadowsLight,
            child: Center(
              child: Text(
                R.stringsOf(context).historyContainer,
                style: txtHeader,
              ),
            ),
          ),
          Expanded(
            child: HistoryComponents(),
          ),
        ],
      ),
    );
  }
}
