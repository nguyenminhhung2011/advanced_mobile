import 'package:flutter/cupertino.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';

@immutable
abstract class UserInfoState {}

class ChangeAvatarSuccess implements UserInfoState {
  const ChangeAvatarSuccess();
}

class GetUserInfoSuccess implements UserInfoState {
  final User userReturn;
  const GetUserInfoSuccess(this.userReturn);
}

class GetUserInfoFailed implements UserInfoState {
  final Object? error;
  final String? message;
  const GetUserInfoFailed({this.error, this.message});

  @override
  String toString() =>
      "GetUserInfoFailed => {message=${message ?? ''}, error=${error ?? ''}}";
}

class FetchTopicsUserInfoSuccess implements UserInfoState {
  const FetchTopicsUserInfoSuccess();
}

class FetchTopicsUserInfoFailed implements UserInfoState {
  final String? message;
  final Object? error;

  const FetchTopicsUserInfoFailed({this.error, this.message});

  @override
  String toString() =>
      "[Fetch topic errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class UpdateProfileUserInfoSuccess implements UserInfoState {
  const UpdateProfileUserInfoSuccess();
}

class UpdateProfileUserInfoFailed implements UserInfoState {
  final String? message;
  final Object? error;

  const UpdateProfileUserInfoFailed({this.error, this.message});

  @override
  String toString() =>
      "[UpdateProfile errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class SelectedTopicUserInfoSuccess implements UserInfoState {
  const SelectedTopicUserInfoSuccess();
}

class PopScreenSuccess implements UserInfoState {
  final User user;
  const PopScreenSuccess(this.user);
}
