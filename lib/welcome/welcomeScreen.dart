import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';
import 'package:nbudget/welcome/welcomeLogic.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WelcomeLogic _wLogic = WelcomeLogic();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Container(
        padding: EdgeInsets.fromLTRB(
            13, MediaQuery.of(context).size.width / 15, 13, 20),
        child: Column(
          children: [
            Text(
              R.stringsOf(context).welcome.toUpperCase(),
              style: welcomelabelTxt(context),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 8),
              child: Image.asset(
                R.images.logo_white,
                width: 205,
                height: 205,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 10),
              child: Text(
                R.stringsOf(context).welcomeText,
                textAlign: TextAlign.justify,
                style: welcomeTxt(context),
              ),
            ),
            Text(
              R.stringsOf(context).welcomeTextFoundError,
              textAlign: TextAlign.justify,
              style: welcomeTxt(context),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(R.stringsOf(context).getStarted),
                    onPressed: () {
                      _wLogic.endWelcomeScreen(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
