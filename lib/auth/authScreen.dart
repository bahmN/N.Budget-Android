import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nbudget/auth/authBloc.dart';
import 'package:nbudget/auth/authService.dart';
import 'package:nbudget/auth/authWidgets.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  AuthService _authService = AuthService();
  AuthBloc _authBloc = AuthBloc();
  AuthWidgets _aWidgets = AuthWidgets();
  void close() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          _aWidgets.logo(context),
          (_authBloc.showLogin
              ? Column(
                  children: [
                    _aWidgets.auth(
                        context,
                        R.stringsOf(context).labelsignInAuth,
                        R.stringsOf(context).signInButtonAuth,
                        _signInButtonAction,
                        _emailController,
                        _passwordController),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          child: Text(
                              R.stringsOf(context).labelBottomSignUpAuth,
                              style: bottomBttn),
                          onTap: () {
                            setState(() {
                              _authBloc.inputEventSink
                                  .add(ButtonEventAuth.eventHide);
                            });
                            _emailController.clear();
                            _passwordController.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _aWidgets.auth(
                        context,
                        R.stringsOf(context).labelsignUpAuth,
                        R.stringsOf(context).signUpButtonAuth,
                        () => _signUpButtonAction,
                        _emailController,
                        _passwordController),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          child: Text(
                              R.stringsOf(context).labelBottomSignInAuth,
                              style: bottomBttn),
                          onTap: () {
                            setState(() {
                              _authBloc.inputEventSink
                                  .add(ButtonEventAuth.eventShow);
                            });
                            _emailController.clear();
                            _passwordController.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                )),
        ],
      ),
    );
  }

  void _signInButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (_email.isEmpty || _password.isEmpty) {
        Fluttertoast.showToast(
            msg: R.stringsOf(context).emptyTextFieldAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).errorColor,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 15.2);
      } else {
        MyUser user = await _authService.signInWithEmailAndPassword(
            _email.trim(), _password.trim());
        if (user == null) {
          Fluttertoast.showToast(
              msg: R.stringsOf(context).emptyUserAuth,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Theme.of(context).errorColor,
              textColor: Theme.of(context).primaryColorLight,
              fontSize: 15.0);
        } else {
          _emailController.clear();
          _passwordController.clear();
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: R.stringsOf(context).conntectionState,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Theme.of(context).errorColor,
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 14.0);
    }
  }

  void _signUpButtonAction(BuildContext context) async {
    _email = _emailController.text;
    _password = _passwordController.text;
    String _emailVal =
        "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
    RegExp emailRegExp = new RegExp(_emailVal);
    String _passwordVal =
        "(?=.*[0-9])(?=.*[!@#%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#%^&*]{6,}";
    RegExp passwordRegExp = new RegExp(_passwordVal);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (!emailRegExp.hasMatch(_email)) {
        Fluttertoast.showToast(
            msg: R.stringsOf(context).incorrectEmailAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).errorColor,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 14.0);
      } else if (!passwordRegExp.hasMatch(_password)) {
        Fluttertoast.showToast(
            msg: R.stringsOf(context).incorrectPasswordAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).errorColor,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 14.0);
      } else {
        MyUser _ = await _authService.signUpWithEmainAndPassword(
            _email.trim(), _password.trim());
        Fluttertoast.showToast(
            msg: R.stringsOf(context).successfulSignUpAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).indicatorColor,
            textColor: Theme.of(context).primaryColorLight,
            fontSize: 14.0);
        _emailController.clear();
        _passwordController.clear();
      }
    } else {
      Fluttertoast.showToast(
          msg: R.stringsOf(context).conntectionState,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Theme.of(context).errorColor,
          textColor: Theme.of(context).primaryColorLight,
          fontSize: 14.0);
    }
  }
}
