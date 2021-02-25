import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Income extends StatefulWidget {
  Income({Key key}) : super(key: key);

  @override
  IncomeState createState() => IncomeState();
}

class IncomeState extends State<Income> {
  var selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Добавить доход'),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 13),
              child: GestureDetector(
                child: Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        color: HexColor('#F5F5F6'),
        child: Column(
          children: [
            Container(
              height: 71,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(1, 4))
                  ]),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 40,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w300),
                cursorColor: HexColor('#FFE60D'),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                cursorHeight: 40,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: '0',
                  hintStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: HexColor('#A7A7A7')),
                  suffixText: '₽',
                  suffixStyle:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 17),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(1, 4))
                  ]),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w300),
                cursorColor: HexColor('#FFE60D'),
                cursorHeight: 20,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Наименование дохода',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: HexColor('#A7A7A7')),
                ),
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: HexColor("#000000").withOpacity(0.35),
                        offset: Offset(1, 4))
                  ]),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 20,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w300),
                maxLines: null,
                cursorColor: HexColor('#FFE60D'),
                cursorHeight: 20,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Комментарий...',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: HexColor('#A7A7A7')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
