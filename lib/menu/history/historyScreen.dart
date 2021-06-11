import 'package:flutter/material.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/menu/menuWidgets.dart';
import 'package:nbudget/r.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ServiceMenu _sMenu = ServiceMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          R.stringsOf(context).nameApp,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.login_rounded),
            onPressed: () async {
              await _sMenu.signOut();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: HistoryWidget(),
      ),
    );
  }
}
