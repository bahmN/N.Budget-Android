import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/styles.dart';

class HistoryComponents extends StatefulWidget {
  HistoryComponents({Key key}) : super(key: key);

  @override
  _HistoryComponentsState createState() => _HistoryComponentsState();
}

class _HistoryComponentsState extends State<HistoryComponents> {
  Widget _listItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Text(
              '${DateFormat('dd-MM-yyyy').format(document['dateCosts'].toDate()).toString()}',
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
                          document['nameCosts'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          document['category'].toString(),
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
                      '-' + document['sumCosts'].toString() + '₽',
                      style: sumHistoryTxt,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).backgroundColor)
          ],
        ),
      ),
    );
  }

  ServiceMenu _sMenu = ServiceMenu();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _sMenu.readHistoryStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                );
              } else {
                return Dismissible(
                  key: ObjectKey(snapshot.data.docs[index]),
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
                      snapshot.data.docs[index].reference.delete(),
                  child: _listItem(context, snapshot.data.docs[index]),
                );
              }
            },
          );
        }
      },
    );
  }
}
