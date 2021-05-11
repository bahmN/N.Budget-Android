import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/r.dart';
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
    return StreamBuilder<List<FinanceItem>>(
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
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorLight),
                  child: Slidable(
                    actionPane: SlidableStrechActionPane(),
                    key: ObjectKey(snapshot.data[index]),
                    actionExtentRatio: 0.20,
                    secondaryActions: [
                      IconSlideAction(
                        caption: R.stringsOf(context).deleteHistory,
                        color: Theme.of(context).errorColor,
                        icon: Icons.delete_rounded,
                        onTap: () async {
                          //TODO: переделать
                          await FirebaseFirestore.instance
                              .collection(snapshot.data[index].type ==
                                      FinanceItemType.income
                                  ? 'Income'
                                  : 'Costs')
                              .doc(snapshot.data[index].id)
                              .delete();
                        },
                      ),
                    ],
                    child: _listItem(context, snapshot.data[index]),
                  ),
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
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Text(
                          item.title,
                          style: nameHistoryTxt,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          item.category,
                          style: nameHistoryTxt,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '- ${item.sum} ₽',
                        style: sumCostsHistoryTxt,
                      ),
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
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Text(
                          item.title,
                          style: nameHistoryTxt,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '+ ${item.sum} ₽',
                        style: sumIncomeHistoryTxt,
                      ),
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
  final String id;
  FinanceItem(
      {@required this.title,
      @required this.sum,
      @required this.type,
      @required this.date,
      @required this.id,
      this.category});
}

enum FinanceItemType { income, costs }
