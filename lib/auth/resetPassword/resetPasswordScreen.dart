import 'package:flutter/material.dart';
import 'package:nbudget/auth/resetPassword/resetPasswordWidgets.dart';
import 'package:nbudget/auth/resetPassword/resetpasswordLogic.dart';
import 'package:nbudget/r.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ResetPasswordWidgets _rpWigets = ResetPasswordWidgets();
    TextEditingController _emailController = TextEditingController();
    ResetPasswordLogic _rpLogic = ResetPasswordLogic();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).primaryColorDark,
        ),
        centerTitle: true,
        title: Text(R.stringsOf(context).resetPassword),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _rpWigets.email(context, _emailController),
            _rpWigets.button(
              context,
              () async => await _rpLogic.resetPassword(
                context,
                _emailController.text.trim(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
