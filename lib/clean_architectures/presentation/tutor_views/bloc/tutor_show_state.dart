import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
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
      "AddTutorFavFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class GetTotalTimeFailed implements TutorShowState {
  final Object? error;
  final String? message;
  const GetTotalTimeFailed({this.error, this.message});

  @override
  String toString() =>
      "GetTotalTimeFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class GetUpComingClassFailed implements TutorShowState {
  final Object? error;
  final String? message;
  const GetUpComingClassFailed({this.error, this.message});

  @override
  String toString() =>
      "GetUpComingClassFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class ChangeFavoriteModeSuccess implements TutorShowState {
  const ChangeFavoriteModeSuccess();
}

class GetTotalTimeSuccess implements TutorShowState {
  const GetTotalTimeSuccess();
}

class GetUpComingClassSuccess implements TutorShowState {
  const GetUpComingClassSuccess();
}

class OpenBeforeMeetingViewSuccess implements TutorShowState {
  final BooInfo args;
  const OpenBeforeMeetingViewSuccess(this.args);
}

class OpenBeforeMeetingViewFailed implements TutorShowState {
  const OpenBeforeMeetingViewFailed();
}
