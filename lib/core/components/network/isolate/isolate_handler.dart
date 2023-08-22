import 'dart:async';
import 'dart:isolate';

typedef MessageHandler = Function(dynamic data);

typedef SendErrorFunction = Function(Object? data);
typedef MainMessageHandler = FutureOr Function(
  dynamic data,
  SendPort sendPort,
);
typedef IsolateMessageHandler = FutureOr Function(
  dynamic data,
  SendPort mSendPort,
  SendErrorFunction sendErrorFunction,
);

class IsolateHandler {
  late Isolate _isolate;
  late ReceivePort _mReceivePort;
  late SendPort _sendPort;
  final _completer = Completer();

  bool get isInitialized => _completer.isCompleted;

  Future<void> initial({  
    required MainMessageHandler mainMessageHandler,
    required IsolateMessageHandler isolateMessageHandler,
    Object? initialMessage = const _NoParameterProvided(),
    MessageHandler? errorHandler,
    MessageHandler? exitHandler,
  }) async {
    assert(isInitialized == false);
    if (isInitialized) return;

    _mReceivePort = ReceivePort();

    final errorPort = _initReceivePort(errorHandler);
    final exitPort = _initReceivePort(exitHandler);

    _isolate = await Isolate.spawn<_IsolateInitialModel>(
      _initIsolateEntry,
      _IsolateInitialModel(
        _mReceivePort.sendPort,
        errorPort?.sendPort,
        isolateMessageHandler,
      ),
      onError: errorPort?.sendPort,
      onExit: exitPort?.sendPort,
    );
    _mReceivePort.listen((message) async {
      //listen from main isolate
      if (message is SendPort) {
        _sendPort = message;
        if (initialMessage is! _NoParameterProvided) {
          _sendPort.send(initialMessage);
        }
        _completer.complete();
        return;
      }
      await mainMessageHandler(message, _sendPort);
    }).onDone(() {
      errorPort?.close();
      exitPort?.close();
    });
    return await _completer.future;
  }

  void sendMessage(Object? data) {
    if (!isInitialized) throw Exception("Isolate isn't initial");
    _sendPort.send(data);
  }

  void dispose() {
    _mReceivePort.close();
    _isolate.kill(priority: Isolate.beforeNextEvent);
  }

  static Future<void> _initIsolateEntry(
    _IsolateInitialModel parameter,
  ) async {
    final isolateRecPort = ReceivePort();

    parameter.mSendPort.send(isolateRecPort.sendPort);

    await for (var data in isolateRecPort) {
      await parameter.isolateMessageHandler(
        data,
        parameter.mSendPort,
        parameter.errorSendPort?.send ?? (_) {},
      );
    }
  }

  ReceivePort? _initReceivePort(MessageHandler? messageHandler) {
    if (messageHandler == null) return null;
    return ReceivePort()..listen(messageHandler);
  }
}

class _IsolateInitialModel {
  final SendPort mSendPort;
  final SendPort? errorSendPort;
  final IsolateMessageHandler isolateMessageHandler;
  _IsolateInitialModel(
    this.mSendPort,
    this.errorSendPort,
    this.isolateMessageHandler,
  );
}

class _NoParameterProvided {
  const _NoParameterProvided();
}
