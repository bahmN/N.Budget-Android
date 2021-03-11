import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nbudget/auth/authService.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/r.dart';

import '../styles.dart';

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
  bool _showLogin = true;
  bool _ifKeyboardOpened = false;
  double _marginTopFormAuth;
  AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    _ifKeyboardOpened = MediaQuery.of(context).viewInsets.bottom > 0;
    _marginTopFormAuth = _ifKeyboardOpened
        ? MediaQuery.of(context).size.height / 5.5
        : MediaQuery.of(context).size.height / 2.4;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          _logo(),
          (_showLogin
              ? Column(
                  children: [
                    _auth(
                        R.stringsOf(context).labelsignInAuth,
                        R.stringsOf(context).signInButtonAuth,
                        _signInButtonAction,
                        _marginTopFormAuth),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5.6),
                      child: GestureDetector(
                        child: Text(R.stringsOf(context).labelBottomSignUpAuth,
                            style: bottomBttn),
                        onTap: () {
                          setState(() {
                            _showLogin = false;
                          });
                          _emailController.clear();
                          _passwordController.clear();
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _auth(
                        R.stringsOf(context).labelsignUpAuth,
                        R.stringsOf(context).signUpButtonAuth,
                        _signUpButtonAction,
                        _marginTopFormAuth),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5.6),
                      child: GestureDetector(
                        child: Text(R.stringsOf(context).labelBottomSignInAuth,
                            style: bottomBttn),
                        onTap: () {
                          setState(() {
                            _showLogin = true;
                          });
                          _emailController.clear();
                          _passwordController.clear();
                        },
                      ),
                    ),
                  ],
                )),
        ],
      ),
    );
  }

  Widget _logo() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.fromLTRB(65, 50, 65, 120),
      child: Image.asset(R.images.logo),
    );
  }

  Widget _auth(
      String label, String labelButton, void func(), double marginTopForm) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.7,
        margin: EdgeInsets.fromLTRB(13, marginTopForm, 13, 0),
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
            _inputLoginOrPassword(Icon(Icons.account_box_rounded),
                R.stringsOf(context).loginHintAuth, _emailController, false),
            _inputLoginOrPassword(
                Icon(Icons.lock_rounded),
                R.stringsOf(context).passwordHintAuth,
                _passwordController,
                true),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 50),
              child: _button(labelButton, func),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputLoginOrPassword(
      Icon icon, String hint, TextEditingController controller, bool obscure) {
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

  Widget _button(String label, void func()) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: func,
      child: Text(label, style: bttnAuth),
      color: Theme.of(context).primaryColor,
    );
  }

  void _signInButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: R.stringsOf(context).emptyTextFieldAuth,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.2);
    } else {
      MyUser user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: R.stringsOf(context).emptyUserAuth,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }
  }

  void _signUpButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    String _emailVal =
        "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
    RegExp emailRegExp = new RegExp(_emailVal);
    String _passwordVal =
        "(?=.*[0-9])(?=.*[!@#%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#%^&*]{6,}";
    RegExp passwordRegExp = new RegExp(_passwordVal);

    if (!emailRegExp.hasMatch(_email)) {
      Fluttertoast.showToast(
          msg: R.stringsOf(context).incorrectEmailAuth,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    } else if (!passwordRegExp.hasMatch(_password)) {
      Fluttertoast.showToast(
          msg: R.stringsOf(context).incorrectPasswordAuth,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      MyUser _ = await _authService.signUpWithEmainAndPassword(
          _email.trim(), _password.trim());
      Fluttertoast.showToast(
          msg: R.stringsOf(context).successfulSignUpAuth,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
      _emailController.clear();
      _passwordController.clear();
      _showLogin = true;
    }
  }
}
