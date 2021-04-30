import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nbudget/landing.dart';

class WelcomeLogic {
  final welcomedata = GetStorage();
  void endWelcomeScreen(context) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (contex) => LandingPage(),
      ),
    );
    welcomedata.write("displayed", true);
  }
}
