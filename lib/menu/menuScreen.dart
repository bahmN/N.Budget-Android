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

class _MenuScreenState extends State<MenuScreen> {
  MenuWidgets _wMenu = MenuWidgets();
  MenuMethods _mMenu = MenuMethods();
  ServiceMenu _sMenu = ServiceMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _wMenu.progressMenu(context),
            _wMenu.infoContainerMenu(context),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 5, top: 20),
                    child: _wMenu.button(
                      context,
                      R.stringsOf(context).incomeLabel,
                      () => _mMenu.navIncomScreen(context),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 20),
                    child: _wMenu.button(
                      context,
                      R.stringsOf(context).costsLabel,
                      () => _mMenu.navCostsScreen(context),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: HistoryWidget(),
            )
          ],
        ),
      ),
    );
  }
}
