import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nbudget/auth/authService.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/landing.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';
import 'package:nbudget/welcome/welcomeScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(NBudget());
}

class NBudget extends StatefulWidget {
  const NBudget({Key key}) : super(key: key);

  @override
  _NBudgetState createState() => _NBudgetState();
}

class _NBudgetState extends State<NBudget> {
  final welcomedata = GetStorage();

  @override
  void initState() {
    super.initState();
    welcomedata.writeIfNull("displayed", false);
  }

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
            home:
                welcomedata.read("displayed") ? LandingPage() : WelcomeScreen(),
          ),
        );
      },
    );
  }
}
