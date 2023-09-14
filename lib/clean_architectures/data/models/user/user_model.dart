import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'email')
  final String email; // or email

  @JsonKey(name: 'name')
  final String name; // or email

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'birthday')
  final DateTime? birthday;

  @JsonKey(name: 'requireNote')
  final String? requireNote;

  @JsonKey(name: 'roles')
  @Default(<String>[])
  final List<String> roles;

  @JsonKey(name: 'isActivated')
  @Default(false)
  final bool isActivated;

  @JsonKey(name: 'isPhoneActivated')
  @Default(false)
  final bool isPhoneActivated;

  @JsonKey(name: 'canSendMessage')
  @Default(false)
  final bool canSendMessage;

  @JsonKey(name: 'timezone')
  final int? timezone;

  UserModel(
    this.id,
    this.email,
    this.name,
    this.phone,
    this.country,
    this.avatar,
    this.birthday,
    this.requireNote,
    this.roles,
    this.isActivated,
    this.isPhoneActivated,
    this.canSendMessage,
    this.timezone,
  );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
