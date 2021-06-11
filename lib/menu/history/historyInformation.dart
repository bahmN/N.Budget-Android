import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbudget/menu/menuComponents.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

// ignore: must_be_immutable
class HistoryInformation extends StatefulWidget {
  HistoryInformation({Key key, this.index, this.item}) : super(key: key);
  int index;
  FinanceItem item;

  @override
  _HistoryInformationState createState() => _HistoryInformationState();
}

class _HistoryInformationState extends State<HistoryInformation> {
  ServiceMenu _sMenu = ServiceMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(R.stringsOf(context).fullHistoryInfo),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      body: StreamBuilder<List<FinanceItem>>(
        stream: _sMenu.items(context),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
            child: Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: borderShadowsLight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          R.stringsOf(context).nameFullHistoryInfo,
                          style: txtHeader,
                        ),
                        Text(snapshot.data[widget.index].title,
                            style: txtNormal),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          R.stringsOf(context).sumFullHistoryInfo,
                          style: txtHeader,
                        ),
                        Text(
                            snapshot.data[widget.index].sum.toString() +
                                R.stringsOf(context).symbolMoney,
                            style: txtNormal),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          R.stringsOf(context).sumFullHistoryInfo,
                          style: txtHeader,
                        ),
                        Text(
                            '${DateFormat('dd-MM-yyyy').format(snapshot.data[widget.index].date).toString()}',
                            style: txtNormal),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          R.stringsOf(context).categoryFullHistoryInfo,
                          style: txtHeader,
                        ),
                        Text(snapshot.data[widget.index].category,
                            style: txtNormal),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          R.stringsOf(context).commentFullHistoryInfo,
                          style: txtHeader,
                        ),
                        Text(snapshot.data[widget.index].comment,
                            style: txtNormal),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
