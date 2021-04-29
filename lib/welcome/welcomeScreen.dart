import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nbudget/landing.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    final welcomedata = GetStorage();
    void _endWelcomeScreen(context) {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => LandingPage(),
        ),
      );
      welcomedata.write("displayed", true);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Container(
        padding: EdgeInsets.fromLTRB(13, 60, 13, 20),
        child: Column(
          children: [
            Center(
              child: Text(
                R.stringsOf(context).welcome.toUpperCase(),
                style: welcomelabelTxt,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8.5),
              child: Image.asset(
                R.images.logo_white,
                width: 205,
                height: 205,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 40),
              child: Text(
                R.stringsOf(context).welcomeText,
                textAlign: TextAlign.justify,
                style: welcomeTxt,
              ),
            ),
            Text(
              R.stringsOf(context).welcomeTextFoundError,
              textAlign: TextAlign.justify,
              style: welcomeTxt,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(R.stringsOf(context).getStarted),
                    onPressed: () {
                      _endWelcomeScreen(context);
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