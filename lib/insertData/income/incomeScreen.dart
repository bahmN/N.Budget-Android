import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nbudget/domains/myUser.dart';
import 'package:nbudget/insertData/income/incomeService.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/insertData/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IncomeScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _sumController = TextEditingController();
  InsertWidgets _wInsert = InsertWidgets();
  IncomeService _sIncome = IncomeService();

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          SharedAxisTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      ),
      child: Scaffold(
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
              onPressed: () async {
                await _sIncome.writeIncome(
                    user.id,
                    _nameController.text.trim(),
                    _commentController.text.trim(),
                    double.parse(_sumController.text),
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
              _wInsert.textSum(context, _sumController),
              DatePickerWidget(),
              _wInsert.textName(context, _nameController),
              _wInsert.textComment(context, _commentController)
            ],
          ),
        ),
      ),
    );
  }
}
