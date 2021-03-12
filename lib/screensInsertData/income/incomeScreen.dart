import 'package:flutter/material.dart';
import 'package:nbudget/r.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).primaryColorDark,
        ),
        title: Text(R.stringsOf(context).incomeLabel),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, //TODO: func for save data
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
    );
  }
}
