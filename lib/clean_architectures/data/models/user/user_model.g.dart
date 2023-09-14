// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as String,
      json['email'] as String,
      json['name'] as String,
      json['phone'] as String?,
      json['country'] as String?,
      json['avatar'] as String?,
      json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      json['requireNote'] as String?,
      (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      json['isActivated'] as bool,
      json['isPhoneActivated'] as bool,
      json['canSendMessage'] as bool,
      json['timezone'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'country': instance.country,
      'avatar': instance.avatar,
      'birthday': instance.birthday?.toIso8601String(),
      'requireNote': instance.requireNote,
      'roles': instance.roles,
      'isActivated': instance.isActivated,
      'isPhoneActivated': instance.isPhoneActivated,
      'canSendMessage': instance.canSendMessage,
      'timezone': instance.timezone,
    };
