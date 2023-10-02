import 'package:flutter/material.dart';

@immutable
abstract class ScheduleState {}

class GetBooHistorySuccess implements ScheduleState {
  const GetBooHistorySuccess();
}

class GetBooHistoryFailed implements ScheduleState {
  final String? message;
  final Object? error;

  const GetBooHistoryFailed({this.error, this.message});

  @override
  String toString() =>
      "[Get boo history errors] => message ${message ?? ''}, error ${error ?? ''} ";
}
