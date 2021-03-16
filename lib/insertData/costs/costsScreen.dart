import 'package:flutter/material.dart';
import 'package:nbudget/insertData/costs/costsService.dart';
import 'package:nbudget/insertData/widgets.dart';
import 'package:nbudget/r.dart';

// ignore: must_be_immutable
class CostsScreen extends StatelessWidget {
  TextEditingController _nameControllerC = TextEditingController();
  TextEditingController _commentControllerC = TextEditingController();
  TextEditingController _sumControllerC = TextEditingController();
  String _category;
  InsertWidgets _wInsert = InsertWidgets();
  CostsService _sCosts = CostsService();
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
        title: Text(R.stringsOf(context).costsLabel),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              isChooseCategory
                  ? _category = R.stringsOf(context).mandatoryExpenses
                  : _category = '';
              await _sCosts.writeCosts(
                  _nameControllerC.text,
                  _commentControllerC.text,
                  double.parse(_sumControllerC.text),
                  _category,
                  selectedDate);
              Navigator.pop(context);
            },
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
            _wInsert.textSum(context, _sumControllerC),
            DatePickerWidget(),
            _wInsert.textName(context, _nameControllerC),
            _wInsert.textComment(context, _commentControllerC),
            Row(
              children: [
                CategoryWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
