import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String id;
  final String userName; // or email
  final String password;
  final String? email;
  final String? phoneNumber;
  final String? creditCardNumber;
  final String? photoUrl;
  final String? bio;
  UserModel({
    this.bio,
    this.email,
    this.phoneNumber, 
    this.creditCardNumber,
    this.photoUrl,
    required this.id,
    required this.userName,
    required this.password,
  });
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
