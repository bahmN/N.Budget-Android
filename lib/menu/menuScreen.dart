import 'package:flutter/material.dart';
import 'package:nbudget/menu/menuBloc.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/menu/menuWidgets.dart';
import 'package:nbudget/r.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

ServiceMenu _sMenu = ServiceMenu();
MenuWidgets _wMenu = MenuWidgets();

class _MenuScreenState extends State<MenuScreen> {
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
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Stack(
              children: [
                _wMenu.progressBlockMenu(context),
                _wMenu.infoContainerMenu(context),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5, top: 20),
                        child: _wMenu.button(
                          context,
                          R.stringsOf(context).incomeLabel,
                          () => navIncomScreen(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, top: 20),
                        child: _wMenu.button(
                          context,
                          R.stringsOf(context).costsLabel,
                          () => navCostsScreen(context),
                        ),
                      ),
                    ),
                  ],
                ),
                HistoryWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
