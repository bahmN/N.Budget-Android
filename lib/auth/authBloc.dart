import 'dart:async';

enum ButtonEventAuth { eventShow, eventHide }

class AuthBloc {
  bool showLogin = true;
  final _inputEventController = StreamController<ButtonEventAuth>();
  StreamSink<ButtonEventAuth> get inputEventSink => _inputEventController.sink;
  final _outputEventController = StreamController<bool>();
  Stream<bool> get outputEventSink => _outputEventController.stream;

  void _mapEventToState(ButtonEventAuth event) {
    if (event == ButtonEventAuth.eventShow) {
      showLogin = true;
    } else if (event == ButtonEventAuth.eventHide) {
      showLogin = false;
    }
  }

  AuthBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void close() {
    _inputEventController.close();
    _outputEventController.close();
  }
}
