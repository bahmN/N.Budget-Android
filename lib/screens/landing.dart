import 'package:flutter/material.dart';
import 'package:nbudget/screens/auth.dart';
import 'package:nbudget/screens/menu.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;
    return isLoggedIn ? MenuPage() : Authorization();
  }
}
