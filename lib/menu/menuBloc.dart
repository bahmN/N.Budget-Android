import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbudget/insertData/costs/costsScreen.dart';
import 'package:nbudget/insertData/income/incomeScreen.dart';
import 'package:rxdart/rxdart.dart';

void navIncomScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => IncomeScreen()));
}

void navCostsScreen(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CostsScreen()));
}

enum ButtonEventMenu { event_Click }

class MenuBloc {
  final _inputEventController = StreamController<ButtonEventMenu>();
  StreamSink<ButtonEventMenu> get inputEventSink => _inputEventController.sink;

  final _outputStateController = BehaviorSubject.seeded(false);
  Stream<bool> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ButtonEventMenu event) {
    if (event == ButtonEventMenu.event_Click) {
      _outputStateController.add(!_outputStateController.value);
    }
  }

  MenuBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void close() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
