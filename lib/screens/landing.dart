import 'package:flutter/material.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/screens/auth.dart';
import 'package:nbudget/screens/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? MenuPage() : Authorization();
  }
}
