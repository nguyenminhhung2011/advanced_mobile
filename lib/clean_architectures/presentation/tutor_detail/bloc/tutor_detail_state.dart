import 'package:flutter/material.dart';

@immutable
abstract class TutorDetailState {}

class GetTutorByIdSuccess implements TutorDetailState {
  const GetTutorByIdSuccess();
}

class GetTutorByIdFailed implements TutorDetailState {
  final Object? error;
  final String? message;

  GetTutorByIdFailed({this.error, this.message});

  @override
  String toString() =>
      "[Get tutors by id errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class InvalidTutorDetail implements TutorDetailState {
  const InvalidTutorDetail();
}