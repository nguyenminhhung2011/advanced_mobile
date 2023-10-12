import 'package:flutter/material.dart';

@immutable
abstract class MainState {}

class GetTopTutorSuccess implements MainState {
  const GetTopTutorSuccess();
}

class GetTopTutorFailed implements MainState {
  final String? message;
  final Object? error;

  const GetTopTutorFailed({this.message, this.error});
  @override
  String toString() => "message $message error $error";
}

class GetTopCourseSuccess implements MainState {
  const GetTopCourseSuccess();
}

class GetTopCourseFailed implements MainState {
  final String? message;
  final Object? error;

  const GetTopCourseFailed({this.message, this.error});
  @override
  String toString() => "message $message error $error";
}

class GetTopEBooSuccess implements MainState {
  const GetTopEBooSuccess();
}

class GetTopEBooFailed implements MainState {
  final String? message;
  final Object? error;

  const GetTopEBooFailed({this.message, this.error});
  @override
  String toString() => "message $message error $error";
}
