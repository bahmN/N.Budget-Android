import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Authorization extends StatefulWidget {
  Authorization({Key key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  TextEditingController _emailController =
      TextEditingController(); //TODO:dispose
  TextEditingController _passwordController =
      TextEditingController(); //TODO:dispose

  String _email;
  String _password;
  bool showLogin = true;
  double _marginFormAuth = 322;
  FocusNode fNode = FocusNode();
  var _isKeyboardVisible = false;

  @override
  void dispose() {
    fNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fNode.addListener(() {
      fNode.hasPrimaryFocus;
    });
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = true;
      });
    }
  }

  Widget _logo() {
    return Container(
      color: HexColor('#FFE60D'),
      width: 411,
      height: 411,
      padding: EdgeInsets.fromLTRB(64, 35, 64, 109),
      child: Image.network(
        'https://clck.ru/TLRoN', //TODO: made 'asset'
      ),
    );
  }

  Widget _inputLoginOrPassword(
      Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 35, 10, 0),
      child: TextField(
        onTap: () {
          setState(() {
            _marginFormAuth = 20;
          });
        },
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
      margin: EdgeInsets.fromLTRB(10, 60, 10, 30),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
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
      child: Center(
        child: GestureDetector(
          onTap: func,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _formAuth(String labelForm, String labelButton, void func()) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.ease,
      margin: EdgeInsets.fromLTRB(13, _marginFormAuth, 13, 50),
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
          Padding(
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

  void _buttonAction() {
    _email = _emailController.text;
    _password = _passwordController.text;

    _emailController.clear();
    _passwordController.clear();
  }

  Widget build(BuildContext context) {
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
                        _formAuth('Авторизация', 'Войти', _buttonAction),
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
                        _formAuth(
                            'Регистрация', 'Зарегистрироваться', _buttonAction),
                        Container(
                          margin: EdgeInsets.fromLTRB(13, 70, 13, 0),
                          child: GestureDetector(
                            child: Text(
                              'Уже зарегестрироваг? Авторизуйся!',
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
