import 'package:flutter/material.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class ResetPasswordWidgets {
  Widget email(BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        style: txtInput,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 20,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: R.stringsOf(context).enterEmail,
          hintStyle: hintTxt,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget button(BuildContext context, void func()) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: func,
        child: Text(
          R.stringsOf(context).resetPassword,
          textAlign: TextAlign.center,
          style: bttnInsertTxt(context),
        ),
      ),
    );
  }
}
