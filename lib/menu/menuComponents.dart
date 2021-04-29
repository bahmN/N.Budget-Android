import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/styles.dart';

// ignore: must_be_immutable
class HistoryComponents extends StatefulWidget {
  HistoryComponents({Key key}) : super(key: key);
  ServiceMenu _sMenu = ServiceMenu();

  @override
  _HistoryComponentsState createState() => _HistoryComponentsState();
}

class _HistoryComponentsState extends State<HistoryComponents> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._sMenu.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                );
              } else {
                return Dismissible(
                  key: ObjectKey(snapshot.data[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 15),
                    color: Theme.of(context).errorColor,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  onDismissed: (direction) =>
                      snapshot.data[index].reference.delete(),
                  child: _listItem(context, snapshot.data[index]),
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _listItem(BuildContext context, FinanceItem item) {
    if (item.type == FinanceItemType.costs) {
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Text(
              '${DateFormat('dd-MM-yyyy').format(item.date).toString()}',
              style: dateTxt,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          item.category,
                          style: nameHistoryTxt,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 125,
                    margin: EdgeInsets.only(left: 25),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- ${item.sum} ₽',
                      style: sumCostsHistoryTxt,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Text(
              '${DateFormat('dd-MM-yyyy').format(item.date).toString()}',
              style: dateTxt,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 125,
                    margin: EdgeInsets.only(left: 25),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '+ ${item.sum} ₽',
                      style: sumIncomeHistoryTxt,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      );
    }
  }
}

class FinanceItem {
  final String title;
  final double sum;
  final FinanceItemType type;
  final DateTime date;
  final String category;
  FinanceItem(
      {@required this.title,
      @required this.sum,
      @required this.type,
      @required this.date,
      @required this.category});
}

enum FinanceItemType { income, costs }
