import 'package:flutter/foundation.dart';

@immutable
abstract class BecomeTutorState {}

class SelectedTopicBecomeTutorSuccess implements BecomeTutorState {
  const SelectedTopicBecomeTutorSuccess();
}

class ChangeAvatarSuccess implements BecomeTutorState {
  const ChangeAvatarSuccess();
}

class FetchTopicsUserInfoBecomeTutorSuccess implements BecomeTutorState {
  const FetchTopicsUserInfoBecomeTutorSuccess();
}

class FetchTopicsUserInfoBecomeTutorFailed implements BecomeTutorState {
  final String? message;
  final Object? error;

  const FetchTopicsUserInfoBecomeTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "[Fetch topic errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class RegisteringTutorSuccess implements BecomeTutorState {
  const RegisteringTutorSuccess();
}

class RegisteringTutorFailed implements BecomeTutorState {
  final String? message;
  final Object? error;

  const RegisteringTutorFailed({this.error, this.message});

  @override
  String toString() =>
      "[Registering tutor errors] => message ${message ?? ''}, error ${error ?? ''} ";
}
