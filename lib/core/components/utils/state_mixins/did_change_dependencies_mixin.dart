import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin DidChangeDependencies<T extends StatefulWidget> on State<T> {
  var _emitted = false;

  final _controller = StreamController<void>.broadcast();

  @nonVirtual
  Stream<void> get didChangeDependencies$ => _controller.stream;

  @mustCallSuper
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) {
      return;
    }
    if (_emitted) {
      return;
    }
    _emitted = true;
    _controller.add(null);
    scheduleMicrotask(_controller.close);
  }
}
