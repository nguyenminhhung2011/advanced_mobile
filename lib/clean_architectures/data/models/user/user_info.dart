import 'package:flutter_base_clean_architecture/clean_architectures/data/models/user/user_model.dart';

class UserInfo {
  final UserModel? user;

  UserInfo(this.user);

  factory UserInfo.fromJson(Map<String, dynamic> data) {
    return UserInfo(
      data['user'] == null ? null : UserModel.fromJson(data['user']),
    );
  }
}
