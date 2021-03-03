import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nbudget/logic/services/database.dart';

class Costs extends StatefulWidget {
  Costs({Key key}) : super(key: key);

  @override
  CostsState createState() => CostsState();
}

class CostsState extends State<Costs> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _sumController = TextEditingController();
  String _name;
  String _comment;
  double _sum;
  //var _idUser;
  var selectedDate = DateTime.now();
  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("ru"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _writeDataAction() async {
    _name = _nameController.text;
    _comment = _commentController.text;
    _sum = double.parse(_sumController.text);
    DatabaseService write = DatabaseService();
    await write.writeCosts(_name, _comment, _sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Добавить расходы'),
        actions: [
          Center(
            child: Container(
              child: FlatButton(
                child: Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  _writeDataAction();
                  Navigator.pop(context);
                },
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
                controller: _sumController,
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
                controller: _nameController,
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
                  hintText: 'Наименование расходов',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: HexColor('#A7A7A7')),
                ),
              ),
            ),
            Container(
              height: 150,
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
                controller: _commentController,
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
                  prefixIcon: Icon(Icons.comment),
                  hintText: 'Комментарий...',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: HexColor('#A7A7A7')),
                ),
              ),
            ),
            Row(
              children: [
                FilterChip(
                  backgroundColor: HexColor('#FFE60D'),
                  label: Text('Обязательные траты'),
                  onSelected: (value) {}, //TODO: допилить radioButton
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
