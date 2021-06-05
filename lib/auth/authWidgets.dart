//TODO: перенести все виджеты сюда
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:nbudget/auth/resetPassword/resetPasswordScreen.dart';
import 'package:nbudget/auth/resetPassword/resetpasswordLogic.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class AuthWidgets {
  Widget logo(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.fromLTRB(65, 50, 65, 120),
      child: Image.asset(R.images.logo),
    );
  }

  Widget auth(
      BuildContext context,
      String label,
      String labelButton,
      void func(),
      TextEditingController emailController,
      TextEditingController passwordController) {
    double _marginTopFormAuth;

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        _marginTopFormAuth = isKeyboardVisible
            ? MediaQuery.of(context).size.height / 5.5
            : MediaQuery.of(context).size.height / 2.4;
        return Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutQuart,
            margin: EdgeInsets.fromLTRB(13, _marginTopFormAuth, 13, 0),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Theme.of(context).shadowColor,
                  offset: Offset(4, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    label.toUpperCase(),
                    style: labelAuth,
                  ),
                ),
                _inputLoginOrPassword(context, Icon(Icons.account_box_rounded),
                    R.stringsOf(context).loginHintAuth, emailController, false),
                _inputLoginOrPassword(
                    context,
                    Icon(Icons.lock_rounded),
                    R.stringsOf(context).passwordHintAuth,
                    passwordController,
                    true),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 40, bottom: 5),
                  child: button(context, labelButton, func),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    child: Text(R.stringsOf(context).forgotPassword,
                        style: bottomBttn),
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputLoginOrPassword(BuildContext context, Icon icon, String hint,
      TextEditingController controller, bool obscure) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: txtInput,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintStyle: txtHintInput,
          hintText: hint,
        ),
      ),
    );
  }

  Widget button(BuildContext context, String label, void func()) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: func,
      child: Text(label, style: bttnAuth),
      color: Theme.of(context).primaryColor,
    );
  }
}
