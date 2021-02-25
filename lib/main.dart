import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/logic/services/auth.dart';
import 'package:nbudget/screens/landing.dart';
import 'package:provider/provider.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('en'),
          const Locale('ru'),
        ],
        title: 'NBudget',
        theme: ThemeData(primaryColor: HexColor('#FFE60D')),
        home: LandingPage(),
      ),
    );
  }
}
