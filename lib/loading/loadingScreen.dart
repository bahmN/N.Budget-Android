import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nbudget/menu/menuScreen.dart';
import 'package:nbudget/r.dart';

class LoadingScreen extends StatefulWidget {
  final String nextRoute;

  LoadingScreen({this.nextRoute});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => MenuScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(R.images.logo),
          Text('W8 pls...'),
        ],
      ),
    );
  }
}
