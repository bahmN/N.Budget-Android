import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: EdgeInsets.only(top: 20),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        style: txtInput,
        maxLength: 50,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 20,
        textCapitalization: TextCapitalization.sentences,
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: MediaQuery.of(context).size.height / 5,
      margin: EdgeInsets.only(top: 20),
      decoration: borderShadowsLight,
      child: TextField(
        controller: controller,
        style: txtInput,
        maxLength: 255,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        cursorColor: Theme.of(context).primaryColor,
        cursorHeight: 20,
        textCapitalization: TextCapitalization.sentences,
        maxLines: 9,
        decoration: InputDecoration(
          hintText: R.stringsOf(context).comment,
          hintStyle: hintTxt,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

var selectedDate = DateTime.now();

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({Key key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(Icons.calendar_today_rounded, size: 20),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: GestureDetector(
              child: Text(
                '${selectedDate.toLocal()}'.split(' ')[0],
                style: txtNormal,
              ),
              onTap: () async {
                final DateTime picked = await showRoundedDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  borderRadius: 5,
                  theme:
                      ThemeData(primaryColor: Theme.of(context).primaryColor),
                  styleDatePicker: datePickerStyle(context),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
                return picked;
              },
            ),
          ),
        ],
      ),
    );
  }
}

bool isChooseCategory = false;

// ignore: must_be_immutable
class CategoryWidget extends StatefulWidget {
  bool isSelected = false;
  CategoryWidget({Key key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: FilterChip(
        backgroundColor: Theme.of(context).accentColor,
        selectedColor: Theme.of(context).primaryColor,
        label:
            Text(R.stringsOf(context).mandatoryExpenses, style: filterChipTxt),
        selected: widget.isSelected,
        onSelected: (bool selected) {
          setState(() {
            widget.isSelected = !widget.isSelected;
          });
          widget.isSelected == true
              ? isChooseCategory = true
              : isChooseCategory = false;
        },
      ),
    );
  }
}
