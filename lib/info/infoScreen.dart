import 'package:flutter/material.dart';
import 'package:nbudget/info/infoLogic.dart';
import 'package:nbudget/info/infoWidgets.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/r.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ServiceMenu _sMenu = ServiceMenu();
  InfoWidget _iWidget = InfoWidget();
  InfoLogic _iLogic = InfoLogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(R.stringsOf(context).nameApp),
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
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            _iWidget.verisonApp(context),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: _iWidget.infoButton(context, () => _iLogic.sendEmail()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
