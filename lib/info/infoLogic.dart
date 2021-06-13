import 'package:flutter/material.dart';
import 'package:nbudget/auth/resetPassword/resetPasswordScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoLogic {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'nbudget.help@gmail.com',
  );
  Future sendEmail() async => await launch(_emailLaunchUri.toString());

  Future resetPassword(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
  }
}
