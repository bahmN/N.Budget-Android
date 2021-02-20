import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/logic/services/auth.dart';

class Authorization extends StatefulWidget {
  Authorization({Key key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;
  bool _ifKeyboardOpened = false;
  double _marginTopFormAuth;
  bool _ifChangedTextAuth = false;

  AuthService _authService = AuthService();

  Widget _logo() {
    return Container(
      color: HexColor('#FFE60D'),
      width: 411,
      height: 411,
      padding: EdgeInsets.fromLTRB(64, 35, 64, 109),
      child: Image.network(
        'https://clck.ru/TLRoN',
      ),
    );
  }

  Widget _inputLoginOrPassword(
      Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 35, 10, 0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 15, color: HexColor('#A7A7A7')),
        cursorColor: HexColor('#FFE60D'),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: HexColor('#A7A7A7'),
          ),
          hintText: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: icon,
          ),
        ),
      ),
    );
  }

  Widget _buttonSignIn(String text, void func()) {
    return Container(
      width: 10000,
      margin: EdgeInsets.fromLTRB(10, 60, 10, 30),
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
          color: HexColor('#FFE60D'),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: HexColor("#000000").withOpacity(0.35),
              offset: Offset(1, 4),
            ),
          ]),
      child: FlatButton(
        onPressed: func,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _formAuth(
      String labelForm, String labelButton, void func(), double marginTopForm) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutQuart,
      margin: EdgeInsets.fromLTRB(13, marginTopForm, 13, 50),
      decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: HexColor("#000000").withOpacity(0.35),
                offset: Offset(4, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 30),
            child: Text(
              labelForm.toUpperCase(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
          ),
          _inputLoginOrPassword(Icon(Icons.account_box_rounded), 'Логин',
              _emailController, false),
          _inputLoginOrPassword(
              Icon(Icons.lock), 'Пароль', _passwordController, true),
          _buttonSignIn(labelButton, func),
        ],
      ),
    );
  }

  void _signInButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    MyUser user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Неправильно введен логин или пароль",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Все ок",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      _emailController.clear();
      _passwordController.clear();
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
          msg: "Некорректный ввод email",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    } else if (!passwordRegExp.hasMatch(_password)) {
      Fluttertoast.showToast(
          msg:
              "Некорректный ввод пароля. Строка должна содержать хотя бы одно число, один спецсимвол, латинскую букву в верхнем и нижнем регистре, строка состоит не менее, чем из 6 символов",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      MyUser user = await _authService.signUpWithEmainAndPassword(
          _email.trim(), _password.trim());
      Fluttertoast.showToast(
          msg: "Вы успешно зарегистрированы",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Widget build(BuildContext context) {
    _ifKeyboardOpened = MediaQuery.of(context).viewInsets.bottom > 0;
    _marginTopFormAuth = _ifKeyboardOpened ? 90 : 322;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: HexColor('#F5F5F6'),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              _logo(),
              (showLogin
                  ? Column(
                      children: <Widget>[
                        _formAuth('Авторизация', 'Войти', _signInButtonAction,
                            _marginTopFormAuth),
                        Container(
                          margin: EdgeInsets.fromLTRB(13, 70, 13, 0),
                          child: GestureDetector(
                            child: Text(
                              'Не зарегистрирован? Зарегистрируйся!',
                              style: TextStyle(
                                  color: HexColor('#A7A7A7'),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200),
                            ),
                            onTap: () {
                              setState(() {
                                showLogin = false;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        _formAuth('Регистрация', 'Зарегистрироваться',
                            _signUpButtonAction, _marginTopFormAuth),
                        Container(
                          margin: EdgeInsets.fromLTRB(13, 70, 13, 0),
                          child: GestureDetector(
                            child: Text(
                              'Уже зарегестрирован? Авторизуйся!',
                              style: TextStyle(
                                  color: HexColor('#A7A7A7'),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200),
                            ),
                            onTap: () {
                              setState(() {
                                showLogin = true;
                              });
                            },
                          ),
                        )
                      ],
                    )),
            ],
          ),
        ],
      ),
    );
  }
}
