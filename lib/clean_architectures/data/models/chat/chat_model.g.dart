// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String,
      content: json['content'] as String,
      isRead: json['isRead'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      fromInfo: ChatInformationModel.fromJson(
          json['fromInfo'] as Map<String, dynamic>),
      toInfo:
          ChatInformationModel.fromJson(json['toInfo'] as Map<String, dynamic>),
      partner: json['partner'] == null
          ? null
          : ChatInformationModel.fromJson(
              json['partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'fromInfo': instance.fromInfo,
      'toInfo': instance.toInfo,
      'partner': instance.partner,
    };
