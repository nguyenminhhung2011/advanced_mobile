// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      bio: json['bio'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      creditCardNumber: json['creditCardNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      id: json['id'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'creditCardNumber': instance.creditCardNumber,
      'photoUrl': instance.photoUrl,
      'bio': instance.bio,
    };
