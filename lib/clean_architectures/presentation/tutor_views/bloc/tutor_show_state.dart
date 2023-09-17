import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class TutorShowState {}

class FetchDataTutorSuccess implements TutorShowState {
  final String message;
  const FetchDataTutorSuccess({this.message = "Fetch data success"});
}

class FetchDataTutorFailed implements TutorShowState {
  final Object? error;
  final String? message;
  const FetchDataTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "FetchDataFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class AddTutorToFavSuccess implements TutorShowState {
  final String message;
  const AddTutorToFavSuccess({this.message = "Fetch data success"});
}

class AddTutorToFavFailed implements TutorShowState {
  final Object? error;
  final String? message;
  const AddTutorToFavFailed({this.error, this.message});

  @override
  String toString() =>
      "FetchDataFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}
