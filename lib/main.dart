import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nbudget/auth/authService.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/landing.dart';
import 'package:nbudget/r.dart';
import 'package:provider/provider.dart';
import 'styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NBudget());
}

class NBudget extends StatelessWidget {
  const NBudget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
        value: AuthService().currentUser,
        builder: (context, snapshot) {
          return AdaptiveTheme(
            light: lightTheme,
            initial: AdaptiveThemeMode.light,
            builder: (light, dark) => MaterialApp(
              theme: light,
              darkTheme: dark,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                RStringsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: RStringsDelegate.supportedLocales,
              home: LandingPage(),
            ),
          );
        });
  }
}
