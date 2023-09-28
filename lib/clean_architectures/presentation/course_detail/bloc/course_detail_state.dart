import 'package:flutter/material.dart';

@immutable
abstract class CourseDetailState {}

class GetCourseDetailSuccess implements CourseDetailState {
  const GetCourseDetailSuccess();
}


class GetCourseDetailFailed implements CourseDetailState {
  final Object? error;
  final String? message;

  GetCourseDetailFailed({this.error, this.message});

  @override
  String toString() =>
      "[GetCourseDetail] => message ${message ?? ''}, error ${error ?? ''} ";
}
