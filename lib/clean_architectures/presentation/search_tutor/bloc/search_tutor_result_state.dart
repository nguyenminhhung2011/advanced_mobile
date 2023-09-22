import 'package:flutter/cupertino.dart';

@immutable
abstract class SearchTutorResultState {}

class SearchTutorSuccess implements SearchTutorResultState {
  final String message;
  const SearchTutorSuccess({this.message = "Search tutor success"});
}

class SearchTutorFailed implements SearchTutorResultState {
  final Object? error;
  final String? message;
  const SearchTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "SearchFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class STRInvalid implements SearchTutorResultState {
  const STRInvalid();
}
