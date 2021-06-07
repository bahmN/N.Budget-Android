import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                stream: _sMenu.widthPB(context, constrains.maxWidth),
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
                  stream: _sMenu.remainderMoney(context),
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
                    stream: _sMenu.readIncomeSum(context),
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
                    stream: _sMenu.readMandatoryCostsSum(context),
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
                    stream: _sMenu.freeMoney(context),
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
                  stream: _sMenu.moneyPerDay(context),
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
                          '${snapshot.data.toStringAsFixed(1)}' +
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
          textAlign: TextAlign.center,
          style: bttnInsertTxt(context),
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

String selectedChoices;

class _HistoryWidgetState extends State<HistoryWidget> {
  void _select(String choice) {
    setState(() {
      selectedChoices = choice;
    });
    showSnackBar();
  }

  void showSnackBar() {
    var snackBarContent;
    if (selectedChoices == R.stringsOf(context).showOnlyCosts) {
      snackBarContent = SnackBar(
        content: Text(
          R.stringsOf(context).selectedFilterCosts,
          style: selectedFilterTxt(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
    } else if (selectedChoices == R.stringsOf(context).showOnlyIncome) {
      snackBarContent = SnackBar(
        content: Text(
          R.stringsOf(context).selectedFilterIncome,
          style: selectedFilterTxt(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
    } else if (selectedChoices == R.stringsOf(context).showAllHistory) {
      snackBarContent = SnackBar(
        content: Text(
          R.stringsOf(context).selectedFilterAll,
          style: selectedFilterTxt(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBarContent);
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = <String>[
      R.stringsOf(context).showOnlyCosts,
      R.stringsOf(context).showOnlyIncome,
      R.stringsOf(context).showAllHistory
    ];
    return Container(
      decoration: borderShadowsLight,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 20,
            decoration: borderDontShadowsLightCircularUp,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.8),
                  child: Text(
                    R.stringsOf(context).historyContainer,
                    style: txtHeader,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      onSelected: _select,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context) {
                        return choices.map(
                          (String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(
                                choice,
                                style: bttnInsertTxt(context),
                              ),
                            );
                          },
                        ).toList();
                      },
                    ),
                  ),
                ),
              ],
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
