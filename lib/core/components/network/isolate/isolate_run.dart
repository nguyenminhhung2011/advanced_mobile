import 'dart:async';
import 'dart:isolate';

import 'package:lettutor/core/components/network/isolate/isolate_handler.dart';

class IsolateRunT<T> {
  final T? data;
  final Function(IsolateProgressData<T> event) progressCall;
  final Function(dynamic data)? errorCall;
  final Function(dynamic data)? exitCall;

  IsolateRunT({
    this.data,
    this.exitCall,
    this.errorCall,
    required this.progressCall,
  });
  final isolateHandler = IsolateHandler();

  static FutureOr Function() eventCall = () {};

  void updateEventCallAndInit({required FutureOr<T> Function() event}) async {
    eventCall = event;
    await _init(event: event);
  }

  Future<void> _init({required FutureOr<T> Function() event}) async {
    await isolateHandler.initial(
      mainMessageHandler: _mainMessageHandler,
      isolateMessageHandler: _isolateMessageHandler,
      errorHandler: errorCall ?? print,
      exitHandler: exitCall ?? print,
    );
    isolateHandler.sendMessage(data);
  }

  static Future<void> _isolateMessageHandler(
    dynamic data,
    SendPort mSendPort,
    SendErrorFunction sendErrorFunction,
  ) async {
    /// Example code
    eventCall.call();
    mSendPort.send(IsolateProgressData(data: data));
  }

  Future<void> _mainMessageHandler(dynamic data, SendPort sendPort) async {
    if (data is IsolateProgressData<T>) {
      progressCall.call(data);
    }
    isolateHandler.dispose();
  }

  static FutureOr<void> run<T>(FutureOr<T> function) {}
}

class IsolateProgressData<T> {
  final T data;
  const IsolateProgressData({required this.data});
}
