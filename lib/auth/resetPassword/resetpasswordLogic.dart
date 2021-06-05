import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nbudget/auth/authService.dart';
import 'package:nbudget/r.dart';

class ResetPasswordLogic {
  AuthService _authService = AuthService();
  Future resetPassword(BuildContext context, String email) async {
    String _emailVal =
        "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
    RegExp emailRegExp = new RegExp(_emailVal);
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (!emailRegExp.hasMatch(email)) {
        Fluttertoast.showToast(
            msg: R.stringsOf(context).incorrectEmailAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).errorColor,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 14.0);
      } else {
        _authService.resetPassword(email);
        Fluttertoast.showToast(
            msg: R.stringsOf(context).messageSentToEmail,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).indicatorColor,
            textColor: Theme.of(context).primaryColorDark,
            fontSize: 14.0);
        Navigator.pop(context);
      }
    }
  }
}
