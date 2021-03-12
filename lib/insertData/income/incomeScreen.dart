import 'package:flutter/material.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/insertData/widgets.dart';

// ignore: must_be_immutable
class IncomeScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _sumController = TextEditingController();
  InsertWidgets _wInsert = InsertWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onPressed: () {
              print('Clicked save');
            }, //TODO: func for save data
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            _wInsert.textSum(context, _sumController),
            _wInsert.datePicker(context),
            _wInsert.textName(context, _nameController),
            _wInsert.textComment(context, _commentController)
          ],
        ),
      ),
    );
  }
}
