import 'package:flutter/material.dart';

@immutable
abstract class ScheduleState {}

class GetBooInfoSuccess implements ScheduleState {
  const GetBooInfoSuccess();
}

class GetBooInfoFailed implements ScheduleState {
  final String? message;
  final Object? error;

  const GetBooInfoFailed({this.error, this.message});

  @override
  String toString() =>
      "[Get boo history errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class CancelBooTutorSuccess implements ScheduleState {
  const CancelBooTutorSuccess();
}

class CancelBooTutorFailed implements ScheduleState {
  final String? message;
  final Object? error;

  const CancelBooTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "[Cancel boo tutor errors] => message ${message ?? ''}, error ${error ?? ''} ";
}
