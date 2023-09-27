import 'package:flutter/material.dart';

@immutable
abstract class TutorDetailState {}

class GetTutorByIdSuccess implements TutorDetailState {
  const GetTutorByIdSuccess();
}

class FavTutorSuccess implements TutorDetailState {
  const FavTutorSuccess();
}

class GetReviewsSuccess implements TutorDetailState {
  const GetReviewsSuccess();
}

class GetTutorByIdFailed implements TutorDetailState {
  final Object? error;
  final String? message;

  GetTutorByIdFailed({this.error, this.message});

  @override
  String toString() =>
      "[Get tutors by id errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class GetReviewsFailed implements TutorDetailState {
  final Object? error;
  final String? message;

  GetReviewsFailed({this.error, this.message});

  @override
  String toString() =>
      "[Get reviews] => message ${message ?? ''}, error ${error ?? ''} ";
}

class FavTutorFailed implements TutorDetailState {
  final Object? error;
  final String? message;

  FavTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "[Fav tutor errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class OpenReportTutorSuccess implements TutorDetailState {
  final String userId;
  OpenReportTutorSuccess({required this.userId});
}

class OpenTutorScheduleSuccess implements TutorDetailState {
  final String userId;
  OpenTutorScheduleSuccess({required this.userId});
}

class InvalidTutorDetail implements TutorDetailState {
  const InvalidTutorDetail();
}
