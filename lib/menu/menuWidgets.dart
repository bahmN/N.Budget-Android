import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbudget/menu/menuBloc.dart';
import 'package:nbudget/menu/menuComponents.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class MenuWidgets {
  ServiceMenu _sMenu = ServiceMenu();

  Widget progressBarMenu(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 50,
      padding: EdgeInsets.only(top: 5),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: borderDontShadowsLightRed,
          ),
          LayoutBuilder(
            builder: (context, constrains) {
              return StreamBuilder<double>(
                stream: widthPB(constrains.maxWidth),
                builder: (context, snapshot) {
                  return AnimatedContainer(
                    duration: Duration(seconds: 3),
                    curve: Curves.ease,
                    decoration: borderDontShadowsLightGreen,
                    width: snapshot.data ?? constrains.maxWidth,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget progressMenu(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(bottom: 20),
      decoration: borderShadowsLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          progressBarMenu(context)
        ],
      ),
    );
  }

  Widget infoContainerMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    stream: _sMenu.readIncomeSum(),
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
                    stream: _sMenu.readMandatoryCostsSum(),
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
      margin: EdgeInsets.only(bottom: 20),
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
  HistoryWidget({Key key, @required this.bloc}) : super(key: key);
  final MenuBloc bloc;
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: borderShadowsLight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 20,
              decoration: borderDontShadowsLightCircularUp,
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
            IconButton(
              icon: Icon(Icons.fullscreen_rounded),
              onPressed: () {
                widget.bloc.inputEventSink.add(ButtonEventMenu.event_Click);
              },
            ),
          ],
        ),
      ),
    );
  }
}
