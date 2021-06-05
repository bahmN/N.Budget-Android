import 'package:flutter/material.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class InfoWidget {
  Widget verisonApp(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          margin: EdgeInsets.only(bottom: 10),
          child: Image.asset(R.images.logo),
        ),
        Text(
          R.stringsOf(context).versionApp,
          style: versionApp(context),
        ),
      ],
    );
  }

  Widget infoButton(BuildContext context, String title, void func()) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: func,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: bttnInsertTxt(context),
        ),
      ),
    );
  }
}
