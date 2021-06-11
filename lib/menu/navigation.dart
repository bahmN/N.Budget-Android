import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nbudget/info/infoScreen.dart';
import 'package:nbudget/menu/history/historyScreen.dart';
import 'package:nbudget/menu/menuScreen.dart';
import 'package:nbudget/r.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List pageList = [
    MenuScreen(),
    HistoryScreen(),
    InfoScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index, AsyncSnapshot<bool> snapshot) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
        child: pageList[_selectedIndex],
      ),
      bottomNavigationBar: StreamBuilder<bool>(
        builder: (context, snapshot) {
          return BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).primaryColorDark,
            unselectedItemColor: Theme.of(context).accentColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: R.stringsOf(context).navBarHome,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: R.stringsOf(context).navBarHistory,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline_rounded),
                label: R.stringsOf(context).navBarInfo,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (value) => _onItemTapped(value, snapshot),
          );
        },
      ),
    );
  }
}
