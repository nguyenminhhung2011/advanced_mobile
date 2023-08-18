import 'dart:isolate';

import 'package:flutter_base_clean_architecture/core/components/network/isolate/isolate_handler.dart';

class IsolateRunT<T> {
  final T data;
  final Function(IsolateProgressData<T> event) progressCall;
  final Function(dynamic data)? errorCall;
  IsolateRunT({
    this.errorCall,
    required this.data,
    required this.progressCall,
  });
  final isolateHandler = IsolateHandler();

  Future<void> init() async {
    isolateHandler.initial(
      mainMessageHandler: mainMessageHandler,
      isolateMessageHandler: isolateMessageHandler,
      errorHandler: errorCall,
      exitHandler: (error) async => null,
    );
  }

  Future<void> mainMessageHandler(dynamic data, SendPort sendPort) async {
    if (data is IsolateProgressData<T>) {
      progressCall.call(data);
    }
  }

  Future<void> isolateMessageHandler(
      dynamic data, SendPort mSendPort, _) async {
        
      }
}

class IsolateProgressData<T> {
  final T data;
  final double progress;
  const IsolateProgressData({
    required this.data,
    required this.progress,
  });
}
