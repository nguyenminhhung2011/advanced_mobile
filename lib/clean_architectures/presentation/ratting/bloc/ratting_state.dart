import 'package:flutter/material.dart';

@immutable
abstract class RattingState {}

class RattingSuccess implements RattingState {
  const RattingSuccess();
}

class RattingFailed implements RattingState {
  final Object? error;
  final String? message;

  RattingFailed({this.error, this.message});

  @override
  String toString() =>
      "[Ratting] => message ${message ?? ''}, error ${error ?? ''} ";
}
