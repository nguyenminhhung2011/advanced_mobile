// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatInformationModel _$ChatInformationModelFromJson(
        Map<String, dynamic> json) =>
    ChatInformationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$ChatInformationModelToJson(
        ChatInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
