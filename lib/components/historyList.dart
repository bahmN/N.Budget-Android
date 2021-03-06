import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/logic/services/database.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  Widget _listItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Text(
              '${DateFormat('dd-MM-yyyy').format(document['dateCosts'].toDate()).toString()}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: HexColor('#A7A7A7'),
              ),
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
                          style: TextStyle(
                            color: HexColor('#A7A7A7'),
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 125,
                    margin: EdgeInsets.only(left: 39),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '-' + document['sumCosts'].toString() + '₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: HexColor('#DBDBDC'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: readHistoryStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(HexColor('#FFE60D')),
            ),
          );
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(HexColor('#FFE60D')),
                );
              } else {
                return Dismissible(
                  key: ObjectKey(snapshot.data.docs[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: HexColor('#E5213E'),
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.delete,
                        color: HexColor('#FFFFFF'),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    snapshot.data.docs[index].reference.delete();
                  },
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
