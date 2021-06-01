import 'package:flutter/material.dart';
import 'package:nbudget/menu/menuBloc.dart';
import 'package:nbudget/menu/menuService.dart';
import 'package:nbudget/menu/menuWidgets.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/welcome/welcomeScreen.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ServiceMenu _sMenu = ServiceMenu();
  MenuWidgets _wMenu = MenuWidgets();
  MenuBloc _bMenu = MenuBloc();
  MenuMethods _mMenu = MenuMethods();
  int _selectedIndex = 0;
  List pageList = [
    MenuScreen(),
    WelcomeScreen(),
  ];
  void _onItemTapped(int index, AsyncSnapshot<bool> snapshot) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      snapshot.data
          ? _bMenu.inputEventSink.add(ButtonEventMenu.event_Click)
          : _bMenu.inputEventSink.add(null);
    } else if (index == 1) {
      snapshot.data
          ? _bMenu.inputEventSink.add(null)
          : _bMenu.inputEventSink.add(ButtonEventMenu.event_Click);
    } else {
      snapshot.data
          ? _bMenu.inputEventSink.add(ButtonEventMenu.event_Click)
          : _bMenu.inputEventSink.add(null);
    }
  }

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
        child: StreamBuilder<bool>(
          stream: _bMenu.outputStateStream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HistoryWidget(bloc: _bMenu),
                    ],
                  )
                : Column(
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
                      HistoryWidget(bloc: _bMenu),
                    ],
                  );
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder<bool>(
          stream: _bMenu.outputStateStream,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).primaryColorDark,
              unselectedItemColor: Theme.of(context).accentColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: R.stringsOf(context).NavBarHome,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: R.stringsOf(context).NavBarHistory,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline_rounded),
                  label: R.stringsOf(context).NavBarInfo,
                )
              ],
              currentIndex: _selectedIndex,
              onTap: (value) => _onItemTapped(value, snapshot),
            );
          }),
    );
  }
}
