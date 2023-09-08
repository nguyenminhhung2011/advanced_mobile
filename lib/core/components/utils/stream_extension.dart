import 'dart:async';

import 'package:flutter/material.dart';

extension DebugMapStreamExtensions on Map<String, Stream<dynamic>> {
  List<StreamSubscription> debug() => entries
      .map((e) =>
          e.value.listen((event) => debugPrint("[DEBUG] [${e.key} => $event]")))
      .toList();
}
