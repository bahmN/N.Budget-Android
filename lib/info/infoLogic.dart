import 'package:url_launcher/url_launcher.dart';

class InfoLogic {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'nbudget.help@gmail.com',
  );
  void sendEmail() async => await launch(_emailLaunchUri.toString());
}
