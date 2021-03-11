import 'dart:async';

enum ButtonEvent { eventShow, eventHide }
bool showLogin = true;

class AuthBloc {
  final _inputEventController = StreamController<ButtonEvent>();
  StreamSink<ButtonEvent> get inputEventSink => _inputEventController.sink;
  final _outputEventController = StreamController<bool>();
  Stream<bool> get outputEventSink => _outputEventController.stream;

  void _mapEventToState(ButtonEvent event) {
    if (event == ButtonEvent.eventShow) {
      showLogin = true;
    } else if (event == ButtonEvent.eventHide) {
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
