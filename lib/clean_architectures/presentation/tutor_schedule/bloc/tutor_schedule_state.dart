import 'package:flutter/material.dart';

@immutable
abstract class TutorScheduleState {}

class GetTutorScheduleSuccess implements TutorScheduleState {
  const GetTutorScheduleSuccess();
}

class GetTutorScheduleFailed implements TutorScheduleState {
  final Object? error;
  final String? message;
  const GetTutorScheduleFailed({this.error, this.message});

  @override
  String toString() =>
      "GetTutorScheduleFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}
