import 'package:flutter/material.dart';
import 'package:nbudget/r.dart';
import 'package:nbudget/styles.dart';

class InsertWidgets {
  Widget textSum(BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.end,
        style: txtInsert,
        keyboardType: TextInputType.number,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 40,
        decoration: InputDecoration(
          suffix: Text(R.stringsOf(context).symbolMoney, style: txtSymbol),
          hintText: '0',
          hintStyle: hintTxtSum,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget textName(BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 20),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        style: txtInput,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 20,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          hintText: R.stringsOf(context).title,
          hintStyle: hintTxt,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget textComment(BuildContext context, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height / 5,
      margin: EdgeInsets.only(top: 20),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        style: txtInput,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 20,
        textCapitalization: TextCapitalization.words,
        maxLines: null,
        decoration: InputDecoration(
          hintText: R.stringsOf(context).comment,
          hintStyle: hintTxt,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget datePicker(BuildContext context) {
    var _selectedDate = DateTime.now();
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(Icons.calendar_today_rounded, size: 20),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: GestureDetector(
              child: Text(
                '${_selectedDate.toLocal()}'.split(' ')[0],
                style: txtNormal,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
