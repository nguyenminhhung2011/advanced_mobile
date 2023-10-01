import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class HomeState {}

class GetCourseCategorySuccess implements HomeState {
  const GetCourseCategorySuccess();
}

class FetchDataCourseSuccess implements HomeState {
  final String message;
  const FetchDataCourseSuccess({this.message = "Fetch data success"});
}

class FetchDataCourseFailed implements HomeState {
  final Object? error;
  final String? message;
  const FetchDataCourseFailed({this.error, this.message});

  @override
  String toString() =>
      "FetchDataFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class GetCourseCategoryFailed implements HomeState {
  final Object? error;
  final String? message;
  const GetCourseCategoryFailed({this.error, this.message});

  @override
  String toString() =>
      "Get course category failed => {message=${message ?? ''}, error=${error ?? ''}}";
}
